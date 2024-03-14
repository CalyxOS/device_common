# Copyright 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

readonly NOT_DEVICE_FLASHER_MESSAGE="Use device-flasher to flash your device properly! See install guide at https://calyxos.org for more info. Enter Y to continue anyway."

# Critical variables
: "${PRODUCT:?Error: PRODUCT variable must be set}"
: "${VERSION:?Error: VERSION variable must be set}"
: "${BUILD:?Error: BUILD variable must be set}"
: "${DEVICE:?Error: DEVICE variable must be set}"

# Optional path prefix
: "${SRCPREFIX:=}"

# Use the default values if they weren't explicitly set
if test "${BOOTLOADERSRC:-}" = ""
then
  BOOTLOADERSRC=bootloader.img
fi
if test "${RADIOSRC:-}" = ""
then
  RADIOSRC=radio.img
fi
if test "${GSCFIRMWARESRC:-}" = ""
then
  GSCFIRMWARESRC=dauntless
fi
if test "${SLEEPDURATION:-}" = ""
then
  SLEEPDURATION=5
fi

# Prepare the staging directory
rm -rf tmp
mkdir -p tmp/$PRODUCT-$VERSION

# Extract the bootloader(s) and radio(s) as necessary
if test "${BOOTLOADER:-}" != "" -a "${BOOTLOADERFILE:-}" = ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/$BOOTLOADERSRC
fi
if test "${RADIO:-}" != "" -a "${RADIOFILE:-}" = ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/$RADIOSRC
fi

# Extract the GSC firmware
unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip VENDOR/firmware/$GSCFIRMWARESRC/*

# Copy the various images in their staging location
cp ${SRCPREFIX}$PRODUCT-img-$BUILD.zip tmp/$PRODUCT-$VERSION/image-$PRODUCT-$VERSION.zip
if test "${BOOTLOADER:-}" != ""
then
  if test "${BOOTLOADERFILE:-}" = ""
  then
    cp tmp/RADIO/$BOOTLOADERSRC tmp/$PRODUCT-$VERSION/bootloader-$DEVICE-$BOOTLOADER.img
  else
    cp "$BOOTLOADERFILE" tmp/$PRODUCT-$VERSION/bootloader-$DEVICE-$BOOTLOADER.img
  fi
fi
if test "${RADIO:-}" != ""
then
  if test "${RADIOFILE:-}" = ""
  then
    cp tmp/RADIO/$RADIOSRC tmp/$PRODUCT-$VERSION/radio-$DEVICE-$RADIO.img
  else
    cp "$RADIOFILE" tmp/$PRODUCT-$VERSION/radio-$DEVICE-$RADIO.img
  fi
fi
cp -r tmp/VENDOR/firmware/$GSCFIRMWARESRC/* tmp/$PRODUCT-$VERSION

if test "${AVB_CUSTOM_KEY:-}" != ""
then
  cp "$AVB_CUSTOM_KEY" tmp/$PRODUCT-$VERSION/avb_custom_key.img
fi

generate_license_linux() {
cat << EOF
# Copyright 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
EOF
}
generate_license_windows() {
generate_license_linux | sed -e 's/^#/::/'
}
generate_header_linux() {
cat << EOF
#!/bin/sh

EOF
generate_license_linux
cat << EOF

set -eu

if test -z "\${DEVICE_FLASHER_VERSION:-}"; then
  printf '$NOT_DEVICE_FLASHER_MESSAGE '
  read answer
  if [ "\$answer" != "Y" ]; then
    exit 1
  fi
fi
fastboot_version="\$("\$(which fastboot)" --version | grep "^fastboot version" | cut -c18-23 | sed 's/\.//g' )"
if ! [ "\${fastboot_version:-0}" -ge 3301 ]; then
  echo "fastboot too old; please download the latest version at https://developer.android.com/studio/releases/platform-tools.html"
  exit 1
fi
if ! fastboot getvar product 2>&1 | grep "^product: $PRODUCT$"; then
  echo "Factory image and device do not match. Please double check"
  exit 1
fi
EOF
}
generate_unlock_and_erase_commands() {
if test "${UNLOCKBOOTLOADER:-}" = "true"
then
cat << EOF
fastboot oem unlock
EOF
fi
if test "${ERASEALL:-}" = "true"
then
cat << EOF
fastboot erase boot
fastboot erase cache
fastboot erase recovery
fastboot erase system
fastboot erase userdata
EOF
fi
}
generate_baseband_commands_generic_linux() {
if test "${BOOTLOADER:-}" != ""
then
cat << EOF
fastboot flash bootloader bootloader-$DEVICE-$BOOTLOADER.img
fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "${RADIO:-}" != ""
then
cat << EOF
fastboot flash radio radio-$DEVICE-$RADIO.img
fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
}
generate_avb_custom_key_commands_linux() {
cat << EOF
fastboot erase avb_custom_key
EOF
if test "${AVB_CUSTOM_KEY:-}" != ""
then
cat << EOF
fastboot flash avb_custom_key avb_custom_key.img
EOF
fi
}
generate_update_image_commands_linux() {
cat << EOF
fastboot -w update image-$PRODUCT-$VERSION.zip
EOF
}
generate_header_windows() {
cat << EOF
@ECHO OFF

EOF
generate_license_windows
cat << EOF

if "%DEVICE_FLASHER_VERSION%"=="" choice /M "$NOT_DEVICE_FLASHER_MESSAGE"
if not %ERRORLEVEL%==1 if "%DEVICE_FLASHER_VERSION%"=="" exit /B 1
PATH=%PATH%;"%SYSTEMROOT%\System32"
fastboot getvar product 2>&1 | findstr /r /c:"^product: $PRODUCT" || echo "Factory image and device do not match. Please double check"
fastboot getvar product 2>&1 | findstr /r /c:"^product: $PRODUCT" || exit /B 1
EOF
}
do_windows_replacements() {
  sed \
    -e 's/^sleep \([0-9]\+\)$/ping -n \1 127.0.0.1 >nul/' \
    -e 's/^\(fastboot .*$\)/\1 || exit \/B 1/' \
    -e 's/\( || exit \/B 1\)\+$/\1/' \

}
generate_baseband_commands_generic_windows() {
generate_baseband_commands_generic_linux | do_windows_replacements
}
generate_avb_custom_key_commands_windows() {
generate_avb_custom_key_commands_linux | do_windows_replacements
}
generate_update_image_commands_windows() {
generate_update_image_commands_linux | do_windows_replacements
}

# Write flash-all.sh
generate_header_linux > tmp/$PRODUCT-$VERSION/flash-all.sh
generate_unlock_and_erase_commands >> tmp/$PRODUCT-$VERSION/flash-all.sh
generate_baseband_commands_generic_linux >> tmp/$PRODUCT-$VERSION/flash-all.sh
generate_avb_custom_key_commands_linux >> tmp/$PRODUCT-$VERSION/flash-all.sh
generate_update_image_commands_linux >> tmp/$PRODUCT-$VERSION/flash-all.sh
chmod a+x tmp/$PRODUCT-$VERSION/flash-all.sh

# Write flash-all.bat
generate_header_windows > tmp/$PRODUCT-$VERSION/flash-all.bat
generate_unlock_and_erase_commands >> tmp/$PRODUCT-$VERSION/flash-all.bat
generate_baseband_commands_generic_windows >> tmp/$PRODUCT-$VERSION/flash-all.bat
generate_avb_custom_key_commands_windows >> tmp/$PRODUCT-$VERSION/flash-all.bat
generate_update_image_commands_windows >> tmp/$PRODUCT-$VERSION/flash-all.bat
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF

echo Press any key to exit...
pause >nul
exit
EOF

# Write flash-base.sh
generate_header_linux > tmp/$PRODUCT-$VERSION/flash-base.sh
generate_baseband_commands_generic_linux >> tmp/$PRODUCT-$VERSION/flash-base.sh
generate_avb_custom_key_commands_linux >> tmp/$PRODUCT-$VERSION/flash-base.sh
chmod a+x tmp/$PRODUCT-$VERSION/flash-base.sh

# Create the distributable package
(cd tmp ; zip -r ../$PRODUCT-$VERSION-factory.zip $PRODUCT-$VERSION)
mv $PRODUCT-$VERSION-factory.zip $PRODUCT-$VERSION-factory-$(sha256sum < $PRODUCT-$VERSION-factory.zip | cut -b -8).zip

# Clean up
rm -rf tmp
