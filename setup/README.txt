================================================================================
Aspectran Application Initial Setup Guide
================================================================================

This document explains how to perform the initial installation of the application
on both Linux and Windows environments.


------------------------
Linux / Unix Setup
------------------------

1. On your target server, create a directory for the setup files.
   > mkdir setup
   > cd setup

2. Create the two initial files, `app.conf` and `install-app.sh`, inside the
   `setup` directory. You can copy them from the source repository's `setup`
   directory.

3. Edit `app.conf` to match your server environment (e.g., `APP_NAME`,
   `DAEMON_USER`, `BASE_DIR`).

4. Grant execute permission to the script.
   > chmod +x install-app.sh

5. Run the installation script. This will clone or pull the entire project
   from Git and set up the application.
   > ./install-app.sh

6. After installation, you can register the application as a systemd service
   by running the script located in the new installation path.
   > [BASE_DIR]/setup/install-service.sh


------------------------
Windows Setup
------------------------

1. On your target server, create a directory for the setup files.
   > mkdir setup
   > cd setup

2. Create the two initial files, `setenv.bat` and `install-app.bat`, inside the
   `setup` directory. You can copy them from the source repository's `setup`
   directory.

3. Edit `setenv.bat` to match your server environment (e.g., `APP_NAME`,
   `BASE_DIR`). Note: `BASE_DIR` should be a Windows-style path like `C:\MyApp`).

4. Run the installation script from the command prompt. This will clone or pull
   the entire project from Git and set up the application.
   > install-app.bat

5. After installation, you can register the application as a Windows Service by
   running the script located in the new installation path (as an Administrator).
   > [BASE_DIR]\app\bin\procrun\install.bat
