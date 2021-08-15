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
if test "$XLOADERSRC" = ""
then
  XLOADERSRC=xloader.img
fi
if test "$BOOTLOADERSRC" = ""
then
  BOOTLOADERSRC=bootloader.img
fi
if test "$RADIOSRC" = ""
then
  RADIOSRC=radio.img
fi
if test "$SLEEPDURATION" = ""
then
  SLEEPDURATION=5
fi

# Prepare the staging directory
rm -rf tmp
mkdir -p tmp/$PRODUCT-$VERSION

# Extract the bootloader(s) and radio(s) as necessary
if test "$XLOADER" != ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/$XLOADERSRC
fi
if test "$BOOTLOADERFILE" = ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/$BOOTLOADERSRC
fi
if test "$RADIO" != "" -a "$RADIOFILE" = ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/$RADIOSRC
fi
if test "$CDMARADIO" != "" -a "$CDMARADIOFILE" = ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/radio-cdma.img
fi
if test "$MI_A2" != ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/bluetooth.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/devcfg.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/dsp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/modem.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/xbl.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/pmic.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/rpm.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/tz.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/hyp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/keymaster.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/cmnlib64.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/cmnlib.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/abl.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/mdtp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/splash.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/mdtpsecapp.img
fi

# Copy the various images in their staging location
cp ${SRCPREFIX}$PRODUCT-img-$BUILD.zip tmp/$PRODUCT-$VERSION/image-$PRODUCT-$VERSION.zip
if test "$XLOADER" != ""
then
  cp tmp/RADIO/$XLOADERSRC tmp/$PRODUCT-$VERSION/xloader-$DEVICE-$XLOADER.img
fi
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
if test "$CDMARADIO" != ""
then
  if test "$CDMARADIOFILE" = ""
  then
    cp tmp/RADIO/radio-cdma.img tmp/$PRODUCT-$VERSION/radio-cdma-$DEVICE-$CDMARADIO.img
  else
    cp $CDMARADIOFILE tmp/$PRODUCT-$VERSION/radio-cdma-$DEVICE-$CDMARADIO.img
  fi
fi
if test "$MI_A2" != ""
then
  cp tmp/RADIO/bluetooth.img tmp/$PRODUCT-$VERSION/bluetooth.img
  cp tmp/RADIO/devcfg.img tmp/$PRODUCT-$VERSION/devcfg.img
  cp tmp/RADIO/dsp.img tmp/$PRODUCT-$VERSION/dsp.img
  cp tmp/RADIO/modem.img tmp/$PRODUCT-$VERSION/modem.img
  cp tmp/RADIO/xbl.img tmp/$PRODUCT-$VERSION/xbl.img
  cp tmp/RADIO/pmic.img tmp/$PRODUCT-$VERSION/pmic.img
  cp tmp/RADIO/rpm.img tmp/$PRODUCT-$VERSION/rpm.img
  cp tmp/RADIO/tz.img tmp/$PRODUCT-$VERSION/tz.img
  cp tmp/RADIO/hyp.img tmp/$PRODUCT-$VERSION/hyp.img
  cp tmp/RADIO/keymaster.img tmp/$PRODUCT-$VERSION/keymaster.img
  cp tmp/RADIO/cmnlib64.img tmp/$PRODUCT-$VERSION/cmnlib64.img
  cp tmp/RADIO/cmnlib.img tmp/$PRODUCT-$VERSION/cmnlib.img
  cp tmp/RADIO/abl.img tmp/$PRODUCT-$VERSION/abl.img
  cp tmp/RADIO/mdtp.img tmp/$PRODUCT-$VERSION/mdtp.img
  cp tmp/RADIO/splash.img tmp/$PRODUCT-$VERSION/splash.img
  cp tmp/RADIO/mdtpsecapp.img tmp/$PRODUCT-$VERSION/mdtpsecapp.img
fi
if test "$AVB_PKMD" != ""
then
  cp "$AVB_PKMD" tmp/$PRODUCT-$VERSION/avb_pkmd.bin
fi

# Write flash-all.sh
cat > tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
#!/bin/sh

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

if ! [ \$(fastboot --version | grep "version" | cut -c18-23 | sed 's/\.//g' ) -ge 2802 ]; then
  echo "fastboot too old; please download the latest version at https://developer.android.com/studio/releases/platform-tools.html"
  exit 1
fi
EOF
if test "$UNLOCKBOOTLOADER" = "true"
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot oem unlock
EOF
fi
if test "$ERASEALL" = "true"
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot erase boot
fastboot erase cache
fastboot erase recovery
fastboot erase system
fastboot erase userdata
EOF
fi
if test "$XLOADER" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot flash xloader xloader-$DEVICE-$XLOADER.img
EOF
fi
if test "$BOOTLOADER" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot flash bootloader bootloader-$DEVICE-$BOOTLOADER.img
EOF
if test "$TWINBOOTLOADERS" = "true"
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot flash bootloader2 bootloader-$DEVICE-$BOOTLOADER.img
EOF
fi
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$RADIO" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot flash radio radio-$DEVICE-$RADIO.img
fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$CDMARADIO" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot flash radio-cdma radio-cdma-$DEVICE-$CDMARADIO.img
fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$MI_A2" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img
fastboot flash pmic_a pmic.img
fastboot flash pmic_b pmic.img
fastboot flash rpm_a rpm.img
fastboot flash rpm_b rpm.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash cmnlib64_a cmnlib64.img
fastboot flash cmnlib64_b cmnlib64.img
fastboot flash cmnlib_a cmnlib.img
fastboot flash cmnlib_b cmnlib.img
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash mdtp_a mdtp.img
fastboot flash mdtp_b mdtp.img
fastboot flash splash splash.img
fastboot flash mdtpsecapp_a mdtpsecapp.img
fastboot flash mdtpsecapp_b mdtpsecapp.img

fastboot erase ddr

fastboot set_active a

fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$AVB_PKMD" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot erase avb_custom_key
fastboot flash avb_custom_key avb_pkmd.bin
fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot -w --skip-reboot update image-$PRODUCT-$VERSION.zip
fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
chmod a+x tmp/$PRODUCT-$VERSION/flash-all.sh

# Write flash-all.bat
cat > tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
@ECHO OFF
:: Copyright 2012 The Android Open Source Project
::
:: Licensed under the Apache License, Version 2.0 (the "License");
:: you may not use this file except in compliance with the License.
:: You may obtain a copy of the License at
::
::      http://www.apache.org/licenses/LICENSE-2.0
::
:: Unless required by applicable law or agreed to in writing, software
:: distributed under the License is distributed on an "AS IS" BASIS,
:: WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
:: See the License for the specific language governing permissions and
:: limitations under the License.

PATH=%PATH%;"%SYSTEMROOT%\System32"

:: Detect Fastboot version with inline PowerShell
:: Should work with Windows 7 and later

@PowerShell ^
\$version=fastboot --version; ^
try { ^
    \$verNum = \$version[0].substring(17, 6); ^
    \$verNum = \$verNum.replace('.', ''); ^
    if ((-Not (\$verNum -gt 2802)) -Or (-Not (\$verNum -match '^[\d.]+$'))) { ^
        Exit 1 ^
    } ^
} catch { ^
    Exit 1 ^
}

IF %ERRORLEVEL% NEQ 0 (
  ECHO fastboot too old; please download the latest version at https://developer.android.com/studio/releases/platform-tools.html
  EXIT /B
)

EOF
if test "$UNLOCKBOOTLOADER" = "true"
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot oem unlock
EOF
fi
if test "$ERASEALL" = "true"
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot erase boot
fastboot erase cache
fastboot erase recovery
fastboot erase system
fastboot erase userdata
EOF
fi
if test "$XLOADER" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot flash xloader xloader-$DEVICE-$XLOADER.img
EOF
fi
if test "$BOOTLOADER" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot flash bootloader bootloader-$DEVICE-$BOOTLOADER.img
EOF
if test "$TWINBOOTLOADERS" = "true"
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot flash bootloader2 bootloader-$DEVICE-$BOOTLOADER.img
EOF
fi
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot reboot-bootloader
ping -n $SLEEPDURATION 127.0.0.1 >nul
EOF
fi
if test "$RADIO" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot flash radio radio-$DEVICE-$RADIO.img
fastboot reboot-bootloader
ping -n $SLEEPDURATION 127.0.0.1 >nul
EOF
fi
if test "$CDMARADIO" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot flash radio-cdma radio-cdma-$DEVICE-$CDMARADIO.img
fastboot reboot-bootloader
ping -n $SLEEPDURATION 127.0.0.1 >nul
EOF
fi
if test "$MI_A2" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img
fastboot flash pmic_a pmic.img
fastboot flash pmic_b pmic.img
fastboot flash rpm_a rpm.img
fastboot flash rpm_b rpm.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash cmnlib64_a cmnlib64.img
fastboot flash cmnlib64_b cmnlib64.img
fastboot flash cmnlib_a cmnlib.img
fastboot flash cmnlib_b cmnlib.img
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash mdtp_a mdtp.img
fastboot flash mdtp_b mdtp.img
fastboot flash splash splash.img
fastboot flash mdtpsecapp_a mdtpsecapp.img
fastboot flash mdtpsecapp_b mdtpsecapp.img

fastboot erase ddr

fastboot set_active a

fastboot reboot-bootloader
ping -n $SLEEPDURATION 127.0.0.1 >nul
EOF
fi
if test "$AVB_PKMD" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot erase avb_custom_key
fastboot flash avb_custom_key avb_pkmd.bin
fastboot reboot-bootloader
ping -n $SLEEPDURATION 127.0.0.1 >nul
EOF
fi
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot -w --skip-reboot update image-$PRODUCT-$VERSION.zip
fastboot reboot-bootloader
ping -n $SLEEPDURATION 127.0.0.1 >nul

echo Press any key to exit...
pause >nul
exit
EOF

# Write flash-base.sh
cat > tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
#!/bin/sh

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

if ! [ \$(\$(which fastboot) --version | grep "version" | cut -c18-23 | sed 's/\.//g' ) -ge 2802 ]; then
  echo "fastboot too old; please download the latest version at https://developer.android.com/studio/releases/platform-tools.html"
  exit 1
fi
EOF
if test "$XLOADER" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot flash xloader xloader-$DEVICE-$XLOADER.img
EOF
fi
if test "$BOOTLOADER" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot flash bootloader bootloader-$DEVICE-$BOOTLOADER.img
EOF
if test "$TWINBOOTLOADERS" = "true"
then
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot flash bootloader2 bootloader-$DEVICE-$BOOTLOADER.img
EOF
fi
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$RADIO" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot flash radio radio-$DEVICE-$RADIO.img
fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$CDMARADIO" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot flash radio-cdma radio-cdma-$DEVICE-$CDMARADIO.img
fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$MI_A2" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img
fastboot flash pmic_a pmic.img
fastboot flash pmic_b pmic.img
fastboot flash rpm_a rpm.img
fastboot flash rpm_b rpm.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash cmnlib64_a cmnlib64.img
fastboot flash cmnlib64_b cmnlib64.img
fastboot flash cmnlib_a cmnlib.img
fastboot flash cmnlib_b cmnlib.img
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash mdtp_a mdtp.img
fastboot flash mdtp_b mdtp.img
fastboot flash splash splash.img
fastboot flash mdtpsecapp_a mdtpsecapp.img
fastboot flash mdtpsecapp_b mdtpsecapp.img

fastboot erase ddr

fastboot set_active a

fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
chmod a+x tmp/$PRODUCT-$VERSION/flash-base.sh

# Create the distributable package
(cd tmp ; zip -r ../$PRODUCT-$VERSION-factory.zip $PRODUCT-$VERSION)
mv $PRODUCT-$VERSION-factory.zip $PRODUCT-$VERSION-factory-$(sha256sum < $PRODUCT-$VERSION-factory.zip | cut -b -8).zip

# Clean up
rm -rf tmp
