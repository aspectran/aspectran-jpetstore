#!/bin/sh
# Pulls the latest source code from the Git repository.
# If the repository is not cloned yet, it will be cloned.

set -e

# Check if git is installed
command -v git >/dev/null || { echo "Error: git is not installed. Please install git and try again."; exit 1; }

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

# Auto-detect development mode if not explicitly set
if [ -z "$DEV_MODE" ] && [ -f "$SCRIPT_DIR/pom.xml" ] && git -C "$SCRIPT_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  DEV_MODE=true
fi

if [ "$DEV_MODE" = "true" ]; then
  echo "Development environment detected."
  echo "Skipping git pull in development mode to preserve local working tree."
  exit 0
fi

TARGET_REPO_DIR="$REPO_DIR"
[ "$DEV_MODE" = "true" ] && TARGET_REPO_DIR="$SCRIPT_DIR"

LOCK_DIR="$TARGET_REPO_DIR/.pull.lock"
SUCCESS_MARKER="$TARGET_REPO_DIR/.pull.success"
PULL_TTL_SECONDS=30

is_recent_pull_available() {
  if [ -f "$SUCCESS_MARKER" ]; then
    local now last_time elapsed
    now=$(date +%s)
    last_time=$(cat "$SUCCESS_MARKER" 2>/dev/null || echo 0)
    elapsed=$((now - last_time))
    if [ "$elapsed" -ge 0 ] && [ "$elapsed" -le "$PULL_TTL_SECONDS" ]; then
      echo "[PULL LOCK] Recent git pull was completed by another node in the shared directory (${elapsed}s ago)."
      echo "[PULL LOCK] Skipping redundant git pull."
      return 0
    fi
  fi
  return 1
}

acquire_lock_or_wait() {
  local wait_count=0

  if is_recent_pull_available; then
    return 1
  fi

  while ! mkdir "$LOCK_DIR" 2>/dev/null; do
    local pid_file="$LOCK_DIR/pid"
    if [ -f "$pid_file" ]; then
      local lock_pid
      lock_pid=$(cat "$pid_file" 2>/dev/null || true)
      if [ -n "$lock_pid" ] && ! kill -0 "$lock_pid" 2>/dev/null; then
        echo "[PULL LOCK] Detected stale lock from terminated process (PID: $lock_pid). Cleaning up..."
        rm -rf "$LOCK_DIR"
        continue
      fi
      if [ "$wait_count" -eq 0 ]; then
        echo "[PULL LOCK] Another node (PID: $lock_pid) is currently pulling in this directory."
        echo "[PULL LOCK] Waiting for active pull to complete..."
      fi
    else
      [ "$wait_count" -eq 0 ] && echo "[PULL LOCK] Another node is initializing git pull. Waiting..."
    fi

    wait_count=$((wait_count + 1))
    sleep 0.5

    if is_recent_pull_available; then
      return 1
    fi
  done

  if is_recent_pull_available; then
    rm -rf "$LOCK_DIR"
    return 1
  fi

  echo $$ > "$LOCK_DIR/pid"
  return 0
}

release_lock() {
  rm -rf "$LOCK_DIR"
}

mark_pull_success() {
  date +%s > "$SUCCESS_MARKER"
}

trap release_lock EXIT INT TERM

if ! acquire_lock_or_wait; then
  exit 0
fi

TARGET_REF="${1:-$PARAM_BRANCH}"

if [ ! -d "$REPO_DIR" ]; then
  [ ! -d "$BUILD_DIR" ] && mkdir -p "$BUILD_DIR"
  cd "$BUILD_DIR"
  if [ -n "$TARGET_REF" ]; then
    echo "Cloning repository with branch/tag: $TARGET_REF ..."
    if ! git clone -b "$TARGET_REF" "$REPO_URL" "$APP_NAME"; then
      echo "[ERROR] Failed to clone branch or tag '$TARGET_REF' from $REPO_URL."
      echo "[ERROR] Please check if the branch or tag name exists."
      exit 1
    fi
  else
    echo "Cloning repository from $REPO_URL ..."
    if ! git clone "$REPO_URL" "$APP_NAME"; then
      echo "[ERROR] Failed to clone repository from $REPO_URL."
      exit 1
    fi
  fi
  mark_pull_success
else
  cd "$REPO_DIR"
  echo "Fetching latest changes and tags from remote repository..."
  if ! git fetch --all --tags --prune; then
    echo "[ERROR] Failed to fetch updates from remote repository."
    exit 1
  fi

  if [ -n "$TARGET_REF" ]; then
    echo "Switching to branch or tag: $TARGET_REF ..."
    if git rev-parse --verify --quiet "refs/tags/$TARGET_REF" >/dev/null 2>&1; then
      echo "Checking out tag '$TARGET_REF'..."
      git checkout -q "refs/tags/$TARGET_REF"
    elif git rev-parse --verify --quiet "refs/heads/$TARGET_REF" >/dev/null 2>&1; then
      echo "Checking out local branch '$TARGET_REF'..."
      git checkout -q "$TARGET_REF"
      if git rev-parse --verify --quiet "origin/$TARGET_REF" >/dev/null 2>&1; then
        git pull --ff-only origin "$TARGET_REF" || git pull origin "$TARGET_REF"
      fi
    elif git rev-parse --verify --quiet "origin/$TARGET_REF" >/dev/null 2>&1; then
      echo "Checking out remote branch 'origin/$TARGET_REF'..."
      git checkout -B "$TARGET_REF" "origin/$TARGET_REF"
    elif git rev-parse --verify --quiet "$TARGET_REF^{commit}" >/dev/null 2>&1; then
      echo "Checking out commit '$TARGET_REF'..."
      git checkout -q "$TARGET_REF"
    else
      echo "[ERROR] Branch, tag, or commit '$TARGET_REF' not found in repository."
      echo "[ERROR] Please check the branch or tag name and try again."
      exit 1
    fi
  else
    echo "Pulling latest changes for current branch..."
    git pull
  fi
  mark_pull_success
fi
