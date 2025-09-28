#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
. "$SCRIPT_DIR/app.conf"

echo "Installing service $APP_NAME ..."

SERVICE_FILE="/etc/systemd/system/$APP_NAME.service"

if [ -f "$SERVICE_FILE" ]; then
  echo "Service $APP_NAME is already installed."
  exit 3
fi

sudo touch $SERVICE_FILE || exit
sudo chmod 644 $SERVICE_FILE || exit

cat <<EOF | sudo tee $SERVICE_FILE >/dev/null || exit
[Unit]
Description=Aspectran service (${APP_NAME})
After=syslog.target network.target

[Service]
Type=forking

User=${DAEMON_USER}
Group=${DAEMON_GROUP:-$DAEMON_USER}

WorkingDirectory=${BASE_DIR}

ExecStart=${BASE_DIR}/startup.sh
ExecStop=${BASE_DIR}/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF

echo --------------------------------------------------------
sudo systemctl cat $APP_NAME
echo --------------------------------------------------------

sudo systemctl daemon-reload || exit
echo "Service $APP_NAME has been installed successfully."
