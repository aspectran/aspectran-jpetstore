#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

if [ -f "$SCRIPT_DIR/app.conf" ]; then
  . "$SCRIPT_DIR/app.conf"
elif [ -f "$SCRIPT_DIR/../app.conf" ]; then
  . "$SCRIPT_DIR/../app.conf"
else
  echo "Error: app.conf file not found."
  exit 1
fi

echo "Installing service $APP_NAME ..."

SERVICE_FILE="/etc/systemd/system/$APP_NAME.service"

if [ -f "$SERVICE_FILE" ]; then
  echo "Service $APP_NAME is already installed."
  exit 3
fi

PID_FILE_PATH="${PID_FILE:-$BASE_DIR/.${PROC_NAME:-$APP_NAME}.pid}"

cat <<EOF | sudo tee $SERVICE_FILE >/dev/null || exit 1
[Unit]
Description=Aspectran service (${APP_NAME})
After=syslog.target network.target

[Service]
Type=forking
User=${DAEMON_USER}
Group=${DAEMON_GROUP:-$DAEMON_USER}
WorkingDirectory=${BASE_DIR}
PIDFile=${PID_FILE_PATH}
ExecStart=${BASE_DIR}/startup.sh
ExecStop=${BASE_DIR}/shutdown.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo chmod 644 $SERVICE_FILE || exit 1

echo "--------------------------------------------------------"
sudo systemctl cat $APP_NAME
echo "--------------------------------------------------------"

sudo systemctl daemon-reload || exit 1
echo "Service $APP_NAME has been installed successfully."
