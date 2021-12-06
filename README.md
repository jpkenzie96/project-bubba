# project-bubba

Project Bubba is an iOS application for nonverbal communication that connects to a MetaMotionC sensor. It is currently located in the StarterProject folder.

## Requirements

- Xcode 13.0
- Device running iOS 15.0 or later with Bluetooth 4.0/5.0 (iOS 13+, XCODE12+, BLE5.0 recommended)
- MetaMotion C Sensor

REQUIREMENT NOTES:
The iOS simulator doesn’t support Bluetooth 4.0/5.0, so test apps must be run on a real iOS device which requires a developer account. This app was built/has constraints for an iPad Pro (12.9 inch).

## Pre-Installation
### CocoaPods
CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects. It has over 79 thousand libraries and is used in over 3 million apps. CocoaPods can help you scale your projects elegantly.

CocoaPods is built with Ruby and is installable with the default Ruby available on macOS. We recommend you use the default ruby.

Using the default Ruby install can require you to use sudo when installing gems. Further installation instructions are in the guides.

>sudo gem install cocoapods

## Installation

Download project-bubba github files at https://github.com/jpkenzie96/project-bubba.git

Now you can install the dependencies for the project in the StarterProject folder:

>pod install

Make sure to always open the Xcode workspace instead of the project file when building the project:

>open StarterProject.xcworkspace

## Usage

Run project on IOS device connected to laptop running Xcode.

