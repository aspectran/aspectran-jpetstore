#!/bin/sh

# Check if git is installed
command -v git >/dev/null || { echo "Error: git is not installed. Please install git and try again."; exit 1; }

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

echo "Installing application to $BASE_DIR ..."

if [ ! -d "$REPO_DIR" ]; then
  git clone "$REPO_URL" "$REPO_DIR" || exit 1
else
  git -C "$REPO_DIR" pull || exit 1
fi

# Create application directory structure
echo "Creating directory structure in $DEPLOY_DIR..."
mkdir -p "$DEPLOY_DIR/bin"
mkdir -p "$DEPLOY_DIR/config"
mkdir -p "$DEPLOY_DIR/lib"
mkdir -p "$DEPLOY_DIR/logs"
mkdir -p "$DEPLOY_DIR/temp"
mkdir -p "$DEPLOY_DIR/work"
mkdir -p "$RESTORE_DIR"
mkdir -p "$BASE_DIR/setup"

# Create optional directories only if they exist in the source repository
if [ -d "$REPO_DIR/app/cmd" ]; then
  mkdir -p "$DEPLOY_DIR/cmd/completed"
  mkdir -p "$DEPLOY_DIR/cmd/failed"
  mkdir -p "$DEPLOY_DIR/cmd/incoming"
  mkdir -p "$DEPLOY_DIR/cmd/queued"
  mkdir -p "$DEPLOY_DIR/cmd/sample"
fi

if [ -d "$REPO_DIR/app/webapps" ]; then
  mkdir -p "$DEPLOY_DIR/webapps"
fi

if [ -d "$REPO_DIR/app/bin" ]; then
  rm -rf "${DEPLOY_DIR:?}"/bin/*
  cp -pR "$REPO_DIR"/app/bin/* "$DEPLOY_DIR/bin"
  chmod +x "$DEPLOY_DIR"/bin/*.sh 2>/dev/null
fi

if [ -d "$REPO_DIR/app/cmd/sample" ]; then
  rm -rf "${DEPLOY_DIR:?}"/cmd/sample/*
  cp -pR "$REPO_DIR"/app/cmd/sample/* "$DEPLOY_DIR/cmd/sample"
fi

cp "$SCRIPT_DIR/app.conf" "$BASE_DIR" || exit 1
cp "$SCRIPT_DIR/app.conf" "$BASE_DIR/setup" 2>/dev/null
if [ -d "$REPO_DIR/setup/scripts/linux" ]; then
  cp "$REPO_DIR"/setup/scripts/linux/*.sh "$BASE_DIR" || exit 1
  chmod +x "$BASE_DIR"/*.sh 2>/dev/null
fi
[ -f "$REPO_DIR/setup/install-service.sh" ] && cp "$REPO_DIR/setup/install-service.sh" "$BASE_DIR/setup"
[ -f "$REPO_DIR/setup/uninstall-service.sh" ] && cp "$REPO_DIR/setup/uninstall-service.sh" "$BASE_DIR/setup"
chmod +x "$BASE_DIR"/setup/*.sh 2>/dev/null

echo "--------------------------------------------------------------------------"
echo "Your application initial setup is complete in $BASE_DIR."
echo
echo "To build and deploy the application, run one of the following scripts:"
echo "  - ./5-pull_build_deploy.sh (recommended for full update)"
echo "  - ./8-pull_deploy_webapps_only.sh (for webapps update only)"
echo "  (Scripts 1 through 9 are available in $BASE_DIR for specific deployment needs)"
echo
echo "After deployment, you can run the application interactively:"
echo "  $DEPLOY_DIR/bin/shell.sh"
echo
echo "To register this application as a service, run the following script:"
echo "  $BASE_DIR/setup/install-service.sh"
echo "You can also remove a registered service by running the following script:"
echo "  $BASE_DIR/setup/uninstall-service.sh"
echo "--------------------------------------------------------------------------"
