#!/bin/sh
pwd
echo "Just for reference!\nProbably still need to setup your android-ndk!!!"
#android_ndk/28.0.12433566/ndk-build NDK_PROJECT_PATH=$(pwd)/build APP_BUILD_SCRIPT=$(pwd)/config/Android.mk
android_ndk/ndk-build NDK_PROJECT_PATH=$(pwd)/build APP_BUILD_SCRIPT=$(pwd)/config/Android.mk
cp build/libs/x86_64/mysendevent .
adb push mysendevent /data/local/tmp/mysendevent
