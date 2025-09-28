#!/bin/sh

# Check if git is installed
command -v git >/dev/null || { echo "Error: git is not installed. Please install git and try again."; exit 1; }

. ./app.conf

echo "Installing application to $BASE_DIR ..."

if [ ! -d "$REPO_DIR" ]; then
  [ ! -d "$BUILD_DIR" ] && mkdir -p "$BUILD_DIR"
  cd "$BUILD_DIR" || exit
  git clone "$REPO_URL" "$APP_NAME"
else
  cd "$REPO_DIR" || exit
  git pull
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

rm -rf "${DEPLOY_DIR:?}"/bin/*
[ -d "$REPO_DIR/app/bin" ] && cp -pR "$REPO_DIR"/app/bin/* "$DEPLOY_DIR/bin"
chmod +x "$DEPLOY_DIR"/bin/*.sh

[ -d "$REPO_DIR/app/cmd/sample" ] && rm -rf "${DEPLOY_DIR:?}"/cmd/sample/*
[ -d "$REPO_DIR/app/cmd/sample" ] && cp -pR "$REPO_DIR"/app/cmd/sample/* "$DEPLOY_DIR/cmd/sample"

cp ./app.conf "$BASE_DIR" || exit
cp "$REPO_DIR"/setup/scripts/linux/*.sh "$BASE_DIR" || exit
chmod +x "$BASE_DIR"/*.sh
cp "$REPO_DIR/setup/install-service.sh" "$BASE_DIR/setup" || exit
cp "$REPO_DIR/setup/uninstall-service.sh" "$BASE_DIR/setup" || exit
chmod +x "$BASE_DIR"/setup/*.sh

echo "--------------------------------------------------------------------------"
echo "Your application initial setup is complete in $BASE_DIR."
echo
echo "To build and deploy the application, run one of the following scripts:"
echo "  - ./5-pull_build_deploy.sh (for full update)"
echo "  - ./8-pull_deploy_webapps_only.sh (for webapps update only)"
echo
echo "After deployment, you can run the application interactively:"
echo "  $DEPLOY_DIR/bin/shell.sh"
echo
echo "To register this application as a service, run the following script:"
echo "  $BASE_DIR/setup/install-service.sh"
echo "You can also remove a registered service by running the following script:"
echo "  $BASE_DIR/setup/uninstall-service.sh"
echo "--------------------------------------------------------------------------"
