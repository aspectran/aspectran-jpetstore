#!/bin/sh
# Builds the application using Maven and deploys the libraries.

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

# Auto-detect development mode if not explicitly set
if [ -z "$DEV_MODE" ] && [ -f "$SCRIPT_DIR/pom.xml" ] && git -C "$SCRIPT_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  DEV_MODE=true
fi

# Check if mvn is installed
command -v mvn >/dev/null || { echo "Error: Maven (mvn) is not installed. Please install it and try again."; exit 1; }

echo "==============================================================================="
echo "Build Environment"
echo "-------------------------------------------------------------------------------"
[ -n "$JAVA_HOME" ] && echo "JAVA_HOME: $JAVA_HOME"
echo "which mvn: $(command -v mvn)"
mvn -version
echo "==============================================================================="

TARGET_BUILD_DIR="$REPO_DIR"
[ "$DEV_MODE" = "true" ] && TARGET_BUILD_DIR="$SCRIPT_DIR"

LOCK_DIR="$TARGET_BUILD_DIR/.build.lock"
SUCCESS_MARKER="$TARGET_BUILD_DIR/.build.success"
BUILD_TTL_SECONDS=30

is_recent_build_available() {
  if [ -f "$SUCCESS_MARKER" ]; then
    local now last_time elapsed
    now=$(date +%s)
    last_time=$(cat "$SUCCESS_MARKER" 2>/dev/null || echo 0)
    elapsed=$((now - last_time))
    if [ "$elapsed" -ge 0 ] && [ "$elapsed" -le "$BUILD_TTL_SECONDS" ]; then
      echo "[BUILD LOCK] Recent build was completed by another node in the shared directory (${elapsed}s ago)."
      echo "[BUILD LOCK] Skipping redundant Maven compilation."
      return 0
    fi
  fi
  return 1
}

acquire_lock_or_wait() {
  local wait_count=0

  if is_recent_build_available; then
    return 1
  fi

  while ! mkdir "$LOCK_DIR" 2>/dev/null; do
    local pid_file="$LOCK_DIR/pid"
    if [ -f "$pid_file" ]; then
      local lock_pid
      lock_pid=$(cat "$pid_file" 2>/dev/null || true)
      if [ -n "$lock_pid" ] && ! kill -0 "$lock_pid" 2>/dev/null; then
        echo "[BUILD LOCK] Detected stale lock from terminated process (PID: $lock_pid). Cleaning up..."
        rm -rf "$LOCK_DIR"
        continue
      fi
      if [ "$wait_count" -eq 0 ]; then
        echo "[BUILD LOCK] Another node (PID: $lock_pid) is currently building in this directory."
        echo "[BUILD LOCK] Waiting for active build to complete..."
      fi
    else
      [ "$wait_count" -eq 0 ] && echo "[BUILD LOCK] Another node is initializing build. Waiting..."
    fi

    wait_count=$((wait_count + 1))
    sleep 0.5

    if is_recent_build_available; then
      return 1
    fi
  done

  if is_recent_build_available; then
    rm -rf "$LOCK_DIR"
    return 1
  fi

  echo $$ > "$LOCK_DIR/pid"
  return 0
}

release_lock() {
  rm -rf "$LOCK_DIR"
}

mark_build_success() {
  date +%s > "$SUCCESS_MARKER"
}

trap release_lock EXIT INT TERM

if ! acquire_lock_or_wait; then
  if [ "$DEV_MODE" != "true" ]; then
    echo "Deploying libraries to $DEPLOY_DIR/lib ..."
    rm -rf "${DEPLOY_DIR:?}"/lib/*
    [ -d "$REPO_DIR/app/lib" ] && cp -pR "$REPO_DIR"/app/lib/* "$DEPLOY_DIR/lib"
  fi
  exit 0
fi

if [ "$DEV_MODE" = "true" ]; then
  echo "Development environment detected. Building in $SCRIPT_DIR ..."
  cd "$SCRIPT_DIR"
  mvn $MAVEN_ARGS package -Dmaven.test.skip=true "$@"
  mark_build_success
  exit 0
fi

cd "$REPO_DIR"

mvn $MAVEN_ARGS -U clean package -Dmaven.test.skip=true "$@"
mark_build_success

echo "Deploying libraries to $DEPLOY_DIR/lib ..."
rm -rf "${DEPLOY_DIR:?}"/lib/*
[ -d "$REPO_DIR/app/lib" ] && cp -pR "$REPO_DIR"/app/lib/* "$DEPLOY_DIR/lib"
