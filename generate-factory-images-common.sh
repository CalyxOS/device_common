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

# Use the default values if they weren't explicitly set
if test "$BOOTLOADERSRC" = ""
then
  BOOTLOADERSRC=bootloader.img
fi
if test "$RADIOSRC" = ""
then
  RADIOSRC=radio.img
fi
if test "$GSCFIRMWARESRC" = ""
then
  GSCFIRMWARESRC=dauntless
fi
if test "$SLEEPDURATION" = ""
then
  SLEEPDURATION=5
fi

# Prepare the staging directory
rm -rf tmp
mkdir -p tmp/$PRODUCT-$VERSION

# Extract the bootloader(s) and radio(s) as necessary
if test "$BOOTLOADER" != "" -a "$BOOTLOADERFILE" = ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/$BOOTLOADERSRC
fi
if test "$RADIO" != "" -a "$RADIOFILE" = ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/$RADIOSRC
fi

# Extract the GSC firmware
unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip VENDOR/firmware/$GSCFIRMWARESRC/*

# Copy the various images in their staging location
cp ${SRCPREFIX}$PRODUCT-img-$BUILD.zip tmp/$PRODUCT-$VERSION/image-$PRODUCT-$VERSION.zip
if test "$BOOTLOADER" != ""
then
  if test "$BOOTLOADERFILE" = ""
  then
    cp tmp/RADIO/$BOOTLOADERSRC tmp/$PRODUCT-$VERSION/bootloader-$DEVICE-$BOOTLOADER.img
  else
    cp $BOOTLOADERFILE tmp/$PRODUCT-$VERSION/bootloader-$DEVICE-$BOOTLOADER.img
  fi
fi
if test "$RADIO" != ""
then
  if test "$RADIOFILE" = ""
  then
    cp tmp/RADIO/$RADIOSRC tmp/$PRODUCT-$VERSION/radio-$DEVICE-$RADIO.img
  else
    cp $RADIOFILE tmp/$PRODUCT-$VERSION/radio-$DEVICE-$RADIO.img
  fi
fi
cp -r tmp/VENDOR/firmware/$GSCFIRMWARESRC/* tmp/$PRODUCT-$VERSION

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

# Write flash-all.sh
generate_header_linux() {
cat << EOF
#!/bin/sh

EOF
generate_license_linux
cat << EOF

if ! [ \$(\$(which fastboot) --version | grep "version" | cut -c18-23 | sed 's/\.//g' ) -ge 3301 ]; then
  echo "fastboot too old; please download the latest version at https://developer.android.com/studio/releases/platform-tools.html"
  exit 1
fi
EOF
}

generate_unlock_and_erase_commands() {
if test "$UNLOCKBOOTLOADER" = "true"
then
cat << EOF
fastboot oem unlock
EOF
fi
if test "$ERASEALL" = "true"
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
if test "$BOOTLOADER" != ""
then
cat << EOF
fastboot flash bootloader bootloader-$DEVICE-$BOOTLOADER.img
fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$RADIO" != ""
then
cat << EOF
fastboot flash radio radio-$DEVICE-$RADIO.img
fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
}

generate_header_linux > tmp/$PRODUCT-$VERSION/flash-all.sh
generate_unlock_and_erase_commands >> tmp/$PRODUCT-$VERSION/flash-all.sh
generate_baseband_commands_generic_linux >> tmp/$PRODUCT-$VERSION/flash-all.sh
generate_update_image_commands_linux() {
cat << EOF
fastboot -w update image-$PRODUCT-$VERSION.zip
EOF
}
generate_update_image_commands_linux >> tmp/$PRODUCT-$VERSION/flash-all.sh
chmod a+x tmp/$PRODUCT-$VERSION/flash-all.sh

# Write flash-all.bat
generate_header_windows() {
cat << EOF
@ECHO OFF

EOF
generate_license_windows
cat << EOF

PATH=%PATH%;"%SYSTEMROOT%\System32"
EOF
}

generate_baseband_commands_generic_windows() {
if test "$BOOTLOADER" != ""
then
cat << EOF
fastboot flash bootloader bootloader-$DEVICE-$BOOTLOADER.img
fastboot reboot-bootloader
ping -n $SLEEPDURATION 127.0.0.1 >nul
EOF
fi
if test "$RADIO" != ""
then
cat << EOF
fastboot flash radio radio-$DEVICE-$RADIO.img
fastboot reboot-bootloader
ping -n $SLEEPDURATION 127.0.0.1 >nul
EOF
}

generate_header_windows > tmp/$PRODUCT-$VERSION/flash-all.bat
generate_unlock_and_erase_commands >> tmp/$PRODUCT-$VERSION/flash-all.bat
generate_baseband_commands_generic_windows >> tmp/$PRODUCT-$VERSION/flash-all.bat
generate_update_image_commands_windows() {
cat << EOF
fastboot -w update image-$PRODUCT-$VERSION.zip
EOF
}
generate_update_image_commands_windows >> tmp/$PRODUCT-$VERSION/flash-all.bat
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF

echo Press any key to exit...
pause >nul
exit
EOF

# Write flash-base.sh
generate_header_linux > tmp/$PRODUCT-$VERSION/flash-base.sh
generate_baseband_commands_generic_linux >> tmp/$PRODUCT-$VERSION/flash-base.sh
chmod a+x tmp/$PRODUCT-$VERSION/flash-base.sh

# Create the distributable package
(cd tmp ; zip -r ../$PRODUCT-$VERSION-factory.zip $PRODUCT-$VERSION)
mv $PRODUCT-$VERSION-factory.zip $PRODUCT-$VERSION-factory-$(sha256sum < $PRODUCT-$VERSION-factory.zip | cut -b -8).zip

# Clean up
rm -rf tmp
