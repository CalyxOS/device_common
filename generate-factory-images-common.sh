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
if test "$SLEEPDURATION" = ""
then
  SLEEPDURATION=5
fi
if test "$FASTBOOT_PRODUCT" = ""
then
  FASTBOOT_PRODUCT=$PRODUCT
fi

# Prepare the staging directory
rm -rf tmp
mkdir -p tmp/$PRODUCT-$VERSION

# Extract the bootloader(s) and radio(s) as necessary
if test "$BOOTLOADERFILE" = ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/$BOOTLOADERSRC
fi
if test "$RADIO" != "" -a "$RADIOFILE" = ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/$RADIOSRC
fi
if test "$FP4" != ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/abl.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/aop.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/bluetooth.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/core_nhlos.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/devcfg.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/devinfo.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/dsp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/featenabler.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/frp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/hyp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/imagefv.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/keymaster.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/modem.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/multiimgoem.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/qupfw.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/tz.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/uefisecapp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/xbl.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/xbl_config.img
fi
if test "$FP5" != ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/abl.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/aop.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/apdp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/bluetooth.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/cpucp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/ddr.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/devcfg.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/dsp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/featenabler.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/frp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/hyp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/imagefv.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/keymaster.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/logfs.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/modem.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/multiimgoem.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/qupfw.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/rtice.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/shrm.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/storsec.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/study.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/studybk.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/tz.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/uefisecapp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/xbl.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/xbl_config.img
fi
if test "$AXOLOTL" != ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/ImageFv.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/abl.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/aop.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/bluetooth.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/cmnlib.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/cmnlib64.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/devcfg.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/devinfo.bin
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/dsp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/frp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/hyp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/keymaster.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/modem.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/qupfw.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/storsec.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/tz.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/xbl.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/xbl_config.img
fi
if test "$MOTO" != ""
then
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/abl.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/bluetooth.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/devcfg.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/dsp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/fsg.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/hyp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/keymaster.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/logo.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/modem.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/partition.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/prov.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/qupfw.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/rpm.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/storsec.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/tz.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/uefisecapp.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/xbl.img
  unzip -d tmp ${SRCPREFIX}$PRODUCT-target_files-$BUILD.zip RADIO/xbl_config.img
fi

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
if test "$FP4" != ""
then
  cp tmp/RADIO/abl.img tmp/$PRODUCT-$VERSION/abl.img
  cp tmp/RADIO/aop.img tmp/$PRODUCT-$VERSION/aop.img
  cp tmp/RADIO/bluetooth.img tmp/$PRODUCT-$VERSION/bluetooth.img
  cp tmp/RADIO/core_nhlos.img tmp/$PRODUCT-$VERSION/core_nhlos.img
  cp tmp/RADIO/devcfg.img tmp/$PRODUCT-$VERSION/devcfg.img
  cp tmp/RADIO/devinfo.img tmp/$PRODUCT-$VERSION/devinfo.img
  cp tmp/RADIO/dsp.img tmp/$PRODUCT-$VERSION/dsp.img
  cp tmp/RADIO/featenabler.img tmp/$PRODUCT-$VERSION/featenabler.img
  cp tmp/RADIO/frp.img tmp/$PRODUCT-$VERSION/frp.img
  cp tmp/RADIO/hyp.img tmp/$PRODUCT-$VERSION/hyp.img
  cp tmp/RADIO/imagefv.img tmp/$PRODUCT-$VERSION/imagefv.img
  cp tmp/RADIO/keymaster.img tmp/$PRODUCT-$VERSION/keymaster.img
  cp tmp/RADIO/modem.img tmp/$PRODUCT-$VERSION/modem.img
  cp tmp/RADIO/multiimgoem.img tmp/$PRODUCT-$VERSION/multiimgoem.img
  cp tmp/RADIO/qupfw.img tmp/$PRODUCT-$VERSION/qupfw.img
  cp tmp/RADIO/tz.img tmp/$PRODUCT-$VERSION/tz.img
  cp tmp/RADIO/uefisecapp.img tmp/$PRODUCT-$VERSION/uefisecapp.img
  cp tmp/RADIO/xbl.img tmp/$PRODUCT-$VERSION/xbl.img
  cp tmp/RADIO/xbl_config.img tmp/$PRODUCT-$VERSION/xbl_config.img
fi
if test "$FP5" != ""
then
  cp tmp/RADIO/abl.img tmp/$PRODUCT-$VERSION/abl.img
  cp tmp/RADIO/aop.img tmp/$PRODUCT-$VERSION/aop.img
  cp tmp/RADIO/apdp.img tmp/$PRODUCT-$VERSION/apdp.img
  cp tmp/RADIO/bluetooth.img tmp/$PRODUCT-$VERSION/bluetooth.img
  cp tmp/RADIO/cpucp.img tmp/$PRODUCT-$VERSION/cpucp.img
  cp tmp/RADIO/ddr.img tmp/$PRODUCT-$VERSION/ddr.img
  cp tmp/RADIO/devcfg.img tmp/$PRODUCT-$VERSION/devcfg.img
  cp tmp/RADIO/dsp.img tmp/$PRODUCT-$VERSION/dsp.img
  cp tmp/RADIO/featenabler.img tmp/$PRODUCT-$VERSION/featenabler.img
  cp tmp/RADIO/frp.img tmp/$PRODUCT-$VERSION/frp.img
  cp tmp/RADIO/hyp.img tmp/$PRODUCT-$VERSION/hyp.img
  cp tmp/RADIO/imagefv.img tmp/$PRODUCT-$VERSION/imagefv.img
  cp tmp/RADIO/keymaster.img tmp/$PRODUCT-$VERSION/keymaster.img
  cp tmp/RADIO/logfs.img tmp/$PRODUCT-$VERSION/logfs.img
  cp tmp/RADIO/modem.img tmp/$PRODUCT-$VERSION/modem.img
  cp tmp/RADIO/multiimgoem.img tmp/$PRODUCT-$VERSION/multiimgoem.img
  cp tmp/RADIO/qupfw.img tmp/$PRODUCT-$VERSION/qupfw.img
  cp tmp/RADIO/rtice.img tmp/$PRODUCT-$VERSION/rtice.img
  cp tmp/RADIO/shrm.img tmp/$PRODUCT-$VERSION/shrm.img
  cp tmp/RADIO/storsec.img tmp/$PRODUCT-$VERSION/storsec.img
  cp tmp/RADIO/study.img tmp/$PRODUCT-$VERSION/study.img
  cp tmp/RADIO/studybk.img tmp/$PRODUCT-$VERSION/studybk.img
  cp tmp/RADIO/tz.img tmp/$PRODUCT-$VERSION/tz.img
  cp tmp/RADIO/uefisecapp.img tmp/$PRODUCT-$VERSION/uefisecapp.img
  cp tmp/RADIO/xbl.img tmp/$PRODUCT-$VERSION/xbl.img
  cp tmp/RADIO/xbl_config.img tmp/$PRODUCT-$VERSION/xbl_config.img
fi
if test "$AXOLOTL" != ""
then
  cp tmp/RADIO/ImageFv.img tmp/$PRODUCT-$VERSION/ImageFv.img
  cp tmp/RADIO/abl.img tmp/$PRODUCT-$VERSION/abl.img
  cp tmp/RADIO/aop.img tmp/$PRODUCT-$VERSION/aop.img
  cp tmp/RADIO/bluetooth.img tmp/$PRODUCT-$VERSION/bluetooth.img
  cp tmp/RADIO/cmnlib.img tmp/$PRODUCT-$VERSION/cmnlib.img
  cp tmp/RADIO/cmnlib64.img tmp/$PRODUCT-$VERSION/cmnlib64.img
  cp tmp/RADIO/devcfg.img tmp/$PRODUCT-$VERSION/devcfg.img
  cp tmp/RADIO/devinfo.bin tmp/$PRODUCT-$VERSION/devinfo.bin
  cp tmp/RADIO/dsp.img tmp/$PRODUCT-$VERSION/dsp.img
  cp tmp/RADIO/frp.img tmp/$PRODUCT-$VERSION/frp.img
  cp tmp/RADIO/hyp.img tmp/$PRODUCT-$VERSION/hyp.img
  cp tmp/RADIO/keymaster.img tmp/$PRODUCT-$VERSION/keymaster.img
  cp tmp/RADIO/modem.img tmp/$PRODUCT-$VERSION/modem.img
  cp tmp/RADIO/qupfw.img tmp/$PRODUCT-$VERSION/qupfw.img
  cp tmp/RADIO/storsec.img tmp/$PRODUCT-$VERSION/storsec.img
  cp tmp/RADIO/tz.img tmp/$PRODUCT-$VERSION/tz.img
  cp tmp/RADIO/xbl.img tmp/$PRODUCT-$VERSION/xbl.img
  cp tmp/RADIO/xbl_config.img tmp/$PRODUCT-$VERSION/xbl_config.img
fi
if test "$MOTO" != ""
then
  cp tmp/RADIO/abl.img tmp/$PRODUCT-$VERSION/abl.img
  cp tmp/RADIO/bluetooth.img tmp/$PRODUCT-$VERSION/bluetooth.img
  cp tmp/RADIO/devcfg.img tmp/$PRODUCT-$VERSION/devcfg.img
  cp tmp/RADIO/dsp.img tmp/$PRODUCT-$VERSION/dsp.img
  cp tmp/RADIO/fsg.img tmp/$PRODUCT-$VERSION/fsg.img
  cp tmp/RADIO/hyp.img tmp/$PRODUCT-$VERSION/hyp.img
  cp tmp/RADIO/keymaster.img tmp/$PRODUCT-$VERSION/keymaster.img
  cp tmp/RADIO/logo.img tmp/$PRODUCT-$VERSION/logo.img
  cp tmp/RADIO/modem.img tmp/$PRODUCT-$VERSION/modem.img
  cp tmp/RADIO/partition.img tmp/$PRODUCT-$VERSION/partition.img
  cp tmp/RADIO/prov.img tmp/$PRODUCT-$VERSION/prov.img
  cp tmp/RADIO/qupfw.img tmp/$PRODUCT-$VERSION/qupfw.img
  cp tmp/RADIO/rpm.img tmp/$PRODUCT-$VERSION/rpm.img
  cp tmp/RADIO/storsec.img tmp/$PRODUCT-$VERSION/storsec.img
  cp tmp/RADIO/tz.img tmp/$PRODUCT-$VERSION/tz.img
  cp tmp/RADIO/uefisecapp.img tmp/$PRODUCT-$VERSION/uefisecapp.img
  cp tmp/RADIO/xbl.img tmp/$PRODUCT-$VERSION/xbl.img
  cp tmp/RADIO/xbl_config.img tmp/$PRODUCT-$VERSION/xbl_config.img
fi

if test "$AVB_CUSTOM_KEY" != ""
then
  cp "$AVB_CUSTOM_KEY" tmp/$PRODUCT-$VERSION/avb_custom_key.img
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

if ! [ \$("\$(which fastboot)" --version | grep "version" | cut -c18-23 | sed 's/\.//g' ) -ge 3301 ]; then
  echo "fastboot too old; please download the latest version at https://developer.android.com/studio/releases/platform-tools.html"
  exit 1
fi
fastboot getvar product 2>&1 | grep "^product: $FASTBOOT_PRODUCT$"
if [ \$? -ne 0 ]; then
  echo "Factory image and device do not match. Please double check"
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
if test "$BOOTLOADER" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot flash --slot=other bootloader bootloader-$DEVICE-$BOOTLOADER.img || exit \$?
fastboot --set-active=other reboot-bootloader || exit \$?
sleep $SLEEPDURATION
fastboot flash --slot=other bootloader bootloader-$DEVICE-$BOOTLOADER.img || exit \$?
fastboot --set-active=other reboot-bootloader || exit \$?
sleep $SLEEPDURATION
EOF
fi
if test "$RADIO" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot flash --slot=other radio radio-$DEVICE-$RADIO.img || exit \$?
fastboot --set-active=other reboot-bootloader || exit \$?
sleep $SLEEPDURATION
fastboot flash --slot=other radio radio-$DEVICE-$RADIO.img || exit \$?
fastboot --set-active=other reboot-bootloader || exit \$?
sleep $SLEEPDURATION
EOF
fi
if test "$FP4" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash aop_a aop.img
fastboot flash aop_b aop.img
fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash core_nhlos_a core_nhlos.img
fastboot flash core_nhlos_b core_nhlos.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash featenabler_a featenabler.img
fastboot flash featenabler_b featenabler.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash imagefv_a imagefv.img
fastboot flash imagefv_b imagefv.img
fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash multiimgoem_a multiimgoem.img
fastboot flash multiimgoem_b multiimgoem.img
fastboot flash qupfw_a qupfw.img
fastboot flash qupfw_b qupfw.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash uefisecapp_a uefisecapp.img
fastboot flash uefisecapp_b uefisecapp.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img
fastboot flash xbl_config_a xbl_config.img
fastboot flash xbl_config_b xbl_config.img

fastboot flash frp frp.img
fastboot flash devinfo devinfo.img

fastboot erase misc
fastboot erase modemst1
fastboot erase modemst2

fastboot --set-active=a reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$FP5" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash aop_a aop.img
fastboot flash aop_b aop.img
fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash cpucp_a cpucp.img
fastboot flash cpucp_b cpucp.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash featenabler_a featenabler.img
fastboot flash featenabler_b featenabler.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash imagefv_a imagefv.img
fastboot flash imagefv_b imagefv.img
fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash multiimgoem_a multiimgoem.img
fastboot flash multiimgoem_b multiimgoem.img
fastboot flash qupfw_a qupfw.img
fastboot flash qupfw_b qupfw.img
fastboot flash shrm_a shrm.img
fastboot flash shrm_b shrm.img
fastboot flash studybk_a studybk.img
fastboot flash studybk_b studybk.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash uefisecapp_a uefisecapp.img
fastboot flash uefisecapp_b uefisecapp.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img
fastboot flash xbl_config_a xbl_config.img
fastboot flash xbl_config_b xbl_config.img

fastboot flash apdp apdp.img
fastboot flash ddr ddr.img
fastboot flash logfs logfs.img
fastboot flash rtice rtice.img
fastboot flash storsec storsec.img
fastboot flash study study.img

fastboot flash frp frp.img

fastboot erase misc
fastboot erase modemst1
fastboot erase modemst2

fastboot --set-active=a

fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$AXOLOTL" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot flash ImageFv_a ImageFv.img
fastboot flash ImageFv_b ImageFv.img
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash aop_a aop.img
fastboot flash aop_b aop.img
fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash cmnlib_a cmnlib.img
fastboot flash cmnlib_b cmnlib.img
fastboot flash cmnlib64_a cmnlib64.img
fastboot flash cmnlib64_b cmnlib64.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash qupfw_a qupfw.img
fastboot flash qupfw_b qupfw.img
fastboot flash storsec_a storsec.img
fastboot flash storsec_b storsec.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img
fastboot flash xbl_config_a xbl_config.img
fastboot flash xbl_config_b xbl_config.img

fastboot flash frp frp.img
fastboot flash devinfo devinfo.bin

fastboot --set-active=a reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$MOTO" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot oem fb_mode_set

fastboot flash partition partition.img

fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash storsec_a storsec.img
fastboot flash storsec_b storsec.img
fastboot flash prov_a prov.img
fastboot flash prov_b prov.img
fastboot flash rpm_a rpm.img
fastboot flash rpm_b rpm.img
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash uefisecapp_a uefisecapp.img
fastboot flash uefisecapp_b uefisecapp.img
fastboot flash qupfw_a qupfw.img
fastboot flash qupfw_b qupfw.img
fastboot flash xbl_config_a xbl_config.img
fastboot flash xbl_config_b xbl_config.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img

fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash fsg_a fsg.img
fastboot flash fsg_b fsg.img

fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash logo_a logo.img
fastboot flash logo_b logo.img

fastboot erase ddr

fastboot oem fb_mode_clear

fastboot --set-active=a reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot erase avb_custom_key
EOF
if test "$AVB_CUSTOM_KEY" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot flash avb_custom_key avb_custom_key.img
EOF
fi
cat >> tmp/$PRODUCT-$VERSION/flash-all.sh << EOF
fastboot --skip-reboot -w update image-$PRODUCT-$VERSION.zip
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
fastboot getvar product 2>&1 | findstr /r /c:"^product: $FASTBOOT_PRODUCT" || echo "Factory image and device do not match. Please double check"
fastboot getvar product 2>&1 | findstr /r /c:"^product: $FASTBOOT_PRODUCT" || exit /B 1
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
if test "$BOOTLOADER" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot flash --slot=other bootloader bootloader-$DEVICE-$BOOTLOADER.img || exit /B 1
fastboot --set-active=other reboot-bootloader || exit /B 1
ping -n $SLEEPDURATION 127.0.0.1 >nul
fastboot flash --slot=other bootloader bootloader-$DEVICE-$BOOTLOADER.img || exit /B 1
fastboot --set-active=other reboot-bootloader || exit /B 1
ping -n $SLEEPDURATION 127.0.0.1 >nul
EOF
fi
if test "$RADIO" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot flash --slot=other radio radio-$DEVICE-$RADIO.img || exit /B 1
fastboot --set-active=other reboot-bootloader || exit /B 1
ping -n $SLEEPDURATION 127.0.0.1 >nul
fastboot flash --slot=other radio radio-$DEVICE-$RADIO.img || exit /B 1
fastboot --set-active=other reboot-bootloader || exit /B 1
ping -n $SLEEPDURATION 127.0.0.1 >nul
EOF
fi
if test "$FP4" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash aop_a aop.img
fastboot flash aop_b aop.img
fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash core_nhlos_a core_nhlos.img
fastboot flash core_nhlos_b core_nhlos.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash featenabler_a featenabler.img
fastboot flash featenabler_b featenabler.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash imagefv_a imagefv.img
fastboot flash imagefv_b imagefv.img
fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash multiimgoem_a multiimgoem.img
fastboot flash multiimgoem_b multiimgoem.img
fastboot flash qupfw_a qupfw.img
fastboot flash qupfw_b qupfw.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash uefisecapp_a uefisecapp.img
fastboot flash uefisecapp_b uefisecapp.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img
fastboot flash xbl_config_a xbl_config.img
fastboot flash xbl_config_b xbl_config.img

fastboot flash frp frp.img
fastboot flash devinfo devinfo.img

fastboot erase misc
fastboot erase modemst1
fastboot erase modemst2

fastboot --set-active=a reboot-bootloader
ping -n $SLEEPDURATION 127.0.0.1 >nul
EOF
fi
if test "$FP5" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash aop_a aop.img
fastboot flash aop_b aop.img
fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash cpucp_a cpucp.img
fastboot flash cpucp_b cpucp.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash featenabler_a featenabler.img
fastboot flash featenabler_b featenabler.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash imagefv_a imagefv.img
fastboot flash imagefv_b imagefv.img
fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash multiimgoem_a multiimgoem.img
fastboot flash multiimgoem_b multiimgoem.img
fastboot flash qupfw_a qupfw.img
fastboot flash qupfw_b qupfw.img
fastboot flash shrm_a shrm.img
fastboot flash shrm_b shrm.img
fastboot flash studybk_a studybk.img
fastboot flash studybk_b studybk.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash uefisecapp_a uefisecapp.img
fastboot flash uefisecapp_b uefisecapp.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img
fastboot flash xbl_config_a xbl_config.img
fastboot flash xbl_config_b xbl_config.img

fastboot flash apdp apdp.img
fastboot flash ddr ddr.img
fastboot flash logfs logfs.img
fastboot flash rtice rtice.img
fastboot flash storsec storsec.img
fastboot flash study study.img

fastboot flash frp frp.img

fastboot erase misc
fastboot erase modemst1
fastboot erase modemst2

fastboot --set-active=a

fastboot reboot-bootloader
ping -n $SLEEPDURATION 127.0.0.1 >nul
EOF
fi
if test "$AXOLOTL" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot flash ImageFv_a ImageFv.img
fastboot flash ImageFv_b ImageFv.img
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash aop_a aop.img
fastboot flash aop_b aop.img
fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash cmnlib_a cmnlib.img
fastboot flash cmnlib_b cmnlib.img
fastboot flash cmnlib64_a cmnlib64.img
fastboot flash cmnlib64_b cmnlib64.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash qupfw_a qupfw.img
fastboot flash qupfw_b qupfw.img
fastboot flash storsec_a storsec.img
fastboot flash storsec_b storsec.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img
fastboot flash xbl_config_a xbl_config.img
fastboot flash xbl_config_b xbl_config.img

fastboot flash frp frp.img
fastboot flash devinfo devinfo.bin

fastboot --set-active=a reboot-bootloader
ping -n $SLEEPDURATION 127.0.0.1 >nul
EOF
fi
if test "$MOTO" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot oem fb_mode_set

fastboot flash partition partition.img

fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash storsec_a storsec.img
fastboot flash storsec_b storsec.img
fastboot flash prov_a prov.img
fastboot flash prov_b prov.img
fastboot flash rpm_a rpm.img
fastboot flash rpm_b rpm.img
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash uefisecapp_a uefisecapp.img
fastboot flash uefisecapp_b uefisecapp.img
fastboot flash qupfw_a qupfw.img
fastboot flash qupfw_b qupfw.img
fastboot flash xbl_config_a xbl_config.img
fastboot flash xbl_config_b xbl_config.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img

fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash fsg_a fsg.img
fastboot flash fsg_b fsg.img

fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash logo_a logo.img
fastboot flash logo_b logo.img

fastboot erase ddr

fastboot oem fb_mode_clear

fastboot --set-active=a reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot erase avb_custom_key
EOF
if test "$AVB_CUSTOM_KEY" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot flash avb_custom_key avb_custom_key.img
EOF
fi
cat >> tmp/$PRODUCT-$VERSION/flash-all.bat << EOF
fastboot --skip-reboot -w update image-$PRODUCT-$VERSION.zip
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

if ! [ \$("\$(which fastboot)" --version | grep "version" | cut -c18-23 | sed 's/\.//g' ) -ge 3301 ]; then
  echo "fastboot too old; please download the latest version at https://developer.android.com/studio/releases/platform-tools.html"
  exit 1
fi
fastboot getvar product 2>&1 | grep "^product: $FASTBOOT_PRODUCT$"
if [ \$? -ne 0 ]; then
  echo "Factory image and device do not match. Please double check"
  exit 1
fi
EOF
if test "$BOOTLOADER" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot flash --slot=other bootloader bootloader-$DEVICE-$BOOTLOADER.img || exit \$?
fastboot --set-active=other reboot-bootloader || exit \$?
sleep $SLEEPDURATION
fastboot flash --slot=other bootloader bootloader-$DEVICE-$BOOTLOADER.img || exit \$?
fastboot --set-active=other reboot-bootloader || exit \$?
sleep $SLEEPDURATION
EOF
fi
if test "$RADIO" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot flash --slot=other radio radio-$DEVICE-$RADIO.img || exit \$?
fastboot --set-active=other reboot-bootloader || exit \$?
sleep $SLEEPDURATION
fastboot flash --slot=other radio radio-$DEVICE-$RADIO.img || exit \$?
fastboot --set-active=other reboot-bootloader || exit \$?
sleep $SLEEPDURATION
EOF
fi
if test "$FP4" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash aop_a aop.img
fastboot flash aop_b aop.img
fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash core_nhlos_a core_nhlos.img
fastboot flash core_nhlos_b core_nhlos.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash featenabler_a featenabler.img
fastboot flash featenabler_b featenabler.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash imagefv_a imagefv.img
fastboot flash imagefv_b imagefv.img
fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash multiimgoem_a multiimgoem.img
fastboot flash multiimgoem_b multiimgoem.img
fastboot flash qupfw_a qupfw.img
fastboot flash qupfw_b qupfw.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash uefisecapp_a uefisecapp.img
fastboot flash uefisecapp_b uefisecapp.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img
fastboot flash xbl_config_a xbl_config.img
fastboot flash xbl_config_b xbl_config.img

fastboot flash userdata userdata.img
fastboot flash metadata metadata.img

fastboot flash frp frp.img
fastboot flash devinfo devinfo.img

fastboot erase misc
fastboot erase modemst1
fastboot erase modemst2

fastboot --set-active=a reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$FP5" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash aop_a aop.img
fastboot flash aop_b aop.img
fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash cpucp_a cpucp.img
fastboot flash cpucp_b cpucp.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash featenabler_a featenabler.img
fastboot flash featenabler_b featenabler.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash imagefv_a imagefv.img
fastboot flash imagefv_b imagefv.img
fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash multiimgoem_a multiimgoem.img
fastboot flash multiimgoem_b multiimgoem.img
fastboot flash qupfw_a qupfw.img
fastboot flash qupfw_b qupfw.img
fastboot flash shrm_a shrm.img
fastboot flash shrm_b shrm.img
fastboot flash studybk_a studybk.img
fastboot flash studybk_b studybk.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash uefisecapp_a uefisecapp.img
fastboot flash uefisecapp_b uefisecapp.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img
fastboot flash xbl_config_a xbl_config.img
fastboot flash xbl_config_b xbl_config.img

fastboot flash apdp apdp.img
fastboot flash ddr ddr.img
fastboot flash logfs logfs.img
fastboot flash rtice rtice.img
fastboot flash storsec storsec.img
fastboot flash study study.img

fastboot flash frp frp.img

fastboot erase misc
fastboot erase modemst1
fastboot erase modemst2

fastboot --set-active=a

fastboot reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$AXOLOTL" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot flash ImageFv_a ImageFv.img
fastboot flash ImageFv_b ImageFv.img
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash aop_a aop.img
fastboot flash aop_b aop.img
fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash cmnlib_a cmnlib.img
fastboot flash cmnlib_b cmnlib.img
fastboot flash cmnlib64_a cmnlib64.img
fastboot flash cmnlib64_b cmnlib64.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash qupfw_a qupfw.img
fastboot flash qupfw_b qupfw.img
fastboot flash storsec_a storsec.img
fastboot flash storsec_b storsec.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img
fastboot flash xbl_config_a xbl_config.img
fastboot flash xbl_config_b xbl_config.img

fastboot flash frp frp.img
fastboot flash devinfo devinfo.bin

fastboot --set-active=a reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
if test "$MOTO" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot oem fb_mode_set

fastboot flash partition partition.img

fastboot flash keymaster_a keymaster.img
fastboot flash keymaster_b keymaster.img
fastboot flash hyp_a hyp.img
fastboot flash hyp_b hyp.img
fastboot flash tz_a tz.img
fastboot flash tz_b tz.img
fastboot flash devcfg_a devcfg.img
fastboot flash devcfg_b devcfg.img
fastboot flash storsec_a storsec.img
fastboot flash storsec_b storsec.img
fastboot flash prov_a prov.img
fastboot flash prov_b prov.img
fastboot flash rpm_a rpm.img
fastboot flash rpm_b rpm.img
fastboot flash abl_a abl.img
fastboot flash abl_b abl.img
fastboot flash uefisecapp_a uefisecapp.img
fastboot flash uefisecapp_b uefisecapp.img
fastboot flash qupfw_a qupfw.img
fastboot flash qupfw_b qupfw.img
fastboot flash xbl_config_a xbl_config.img
fastboot flash xbl_config_b xbl_config.img
fastboot flash xbl_a xbl.img
fastboot flash xbl_b xbl.img

fastboot flash modem_a modem.img
fastboot flash modem_b modem.img
fastboot flash fsg_a fsg.img
fastboot flash fsg_b fsg.img

fastboot flash bluetooth_a bluetooth.img
fastboot flash bluetooth_b bluetooth.img
fastboot flash dsp_a dsp.img
fastboot flash dsp_b dsp.img
fastboot flash logo_a logo.img
fastboot flash logo_b logo.img

fastboot erase ddr

fastboot oem fb_mode_clear

fastboot --set-active=a reboot-bootloader
sleep $SLEEPDURATION
EOF
fi
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot erase avb_custom_key
EOF
if test "$AVB_CUSTOM_KEY" != ""
then
cat >> tmp/$PRODUCT-$VERSION/flash-base.sh << EOF
fastboot flash avb_custom_key avb_custom_key.img
EOF
fi
chmod a+x tmp/$PRODUCT-$VERSION/flash-base.sh

# Create the distributable package
(cd tmp ; zip -r ../$PRODUCT-$VERSION-factory.zip $PRODUCT-$VERSION)
mv $PRODUCT-$VERSION-factory.zip $PRODUCT-$VERSION-factory-$(sha256sum < $PRODUCT-$VERSION-factory.zip | cut -b -8).zip

# Clean up
rm -rf tmp
