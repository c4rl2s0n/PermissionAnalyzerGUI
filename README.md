# Android Network Analyzer

## 1) About this Project
This project was created in the context of the 'Traffic Monitoring and Analysis' lecture of the Master in Cybersecurity at UPC Barcelona.

We created a tool to facilitate the process of capturing network traffic from Android applications by
* automating the process of generating comparable network traffic (by recording and replaying user input to the device)
* analyzing the collected data, by
  * grouping the network packets to different connections
  * grouping the connections by domains/server names/ip ranges
  * measuring the traffic volumes on those connections
  * showing the endpoints on a map
  * presenting the traffic volume of the connections in time-sensitive relation to a screen recording of the performed test

## 2) Prerequisites
### 2.1) Rooted Mobile Device
This tool works with Android devices and requires the device to be rooted to function properly.
An easy way to achieve this, is to setup an Android emulator (using a system image without the Google APIs, to enable root access).

### 2.2) Android Debug Bridge
To interact with the Android device, the tool uses the Android Debug Bridge ([adb](https://developer.android.com/tools/adb)).
To test, if the Android device provides root-access, simply run `adb root` from the commandline.

### 2.3) TShark
To capture the network traffic, the tool uses [Tshark](https://tshark.dev/setup/install/), the commandline version of [Wireshark](https://www.wireshark.org/).
When installing Wireshark, it is important to also install the extension [androiddump](https://www.wireshark.org/docs/man-pages/androiddump.html) to be able to capture the traffic from the device.

## 3) Get the Tool
### 3.1) Precompiled
Download the precompiled program from the GitHub-Releases.
Precompiled versions are currently available for Mac and Linux.
Windows should also be supported, but is currently not very well tested, as the main development took place on Linux and most of the tests were performed on Mac.

### 3.2) Compile it yourself
In order to compile the program by yourself, just clone the repository, setup the [Flutter](https://docs.flutter.dev/get-started/install) environment and build the project.

## 4) Use the Tool
In order to use the tool, follow these steps to get started with analysing Android applications:

###  4.1) Setup
1. Connect your Android device to the computer.
2. At the first start, go to the Settings page and set 
   1. the path of the **adb**-executable
   2. the path of the **tshark**-executable
   3. choose the architecture of your mobile device
   4. select the connected Android device (if it is not shown, click the button to rescan for adb-devices)
3. Go back to the main page and create a new application
   1. Select the device you want to use for testing
   2. Select the application you want to test (they are listed by their IDs, so you might have to lookup the ID on the app store or somewhere else)
   3. Enter the name of the application manually
   4. (optional and not important) On Linux/Mac, you can try to extract the app-icon from the application, but it might fail in case the icon has an unexpected filename

### 4.2) Scenarios
After selecting the application you want to test, you can create different test-scenarios.
A scenario defines some settings about the tests, including:
* the network interface to capture the traffic
* the duration of each test,
* whether or not to record the screen during each test (in that case, the maximum test duration is 180 seconds)
* whether or not to capture the traffic
* the number of tests to be performed (after running some tests, this number can only be increased to run more tests)

Also, TestConstellations can be created, which contain a set of permissions and whether or not to