#!/bin/bash

# This script builds and installs Luminance for all users. Root permissions are needed

if [ `whoami` != "root" ]
then
  echo "Not root. Exiting..."
  exit
fi

echo "Building app..."
./build-debug.sh

echo "Copying app to /usr/bin..."
cp ./build/app.debug /usr/bin/com.sidevesh.Luminance

echo "Copying desktop file to /usr/share/applications..."
cp ./install_files/com.sidevesh.Luminance.desktop /usr/share/applications/com.sidevesh.Luminance.desktop

echo "Copying GSettings schema..."
cp ./install_files/com.sidevesh.Luminance.gschema.xml /usr/share/glib-2.0/schemas/com.sidevesh.Luminance.gschema.xml

echo "Copying udev rules..."
cp ./install_files/44-backlight-permissions.rules /usr/lib/udev/rules.d/44-backlight-permissions.rules

echo "Copying icons..."
cp ./icons/hicolor/scalable/apps/com.sidevesh.Luminance.Devel.svg /usr/share/icons/hicolor/scalable/apps/com.sidevesh.Luminance.svg
cp ./icons/hicolor/symbolic/apps/com.sidevesh.Luminance-symbolic.svg /usr/share/icons/hicolor/symbolic/apps/com.sidevesh.Luminance-symbolic.svg

echo "Compiling schemas and updating icon cache..."
glib-compile-schemas /usr/share/glib-2.0/schemas/
gtk-update-icon-cache /usr/share/icons/hicolor/

echo "Installed successfully"
