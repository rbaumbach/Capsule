# Capsule [![Cocoapod Version](https://img.shields.io/cocoapods/v/Capsule.svg)](https://github.com/rbaumbach/Capsule) [![SPM Compatible](https://img.shields.io/badge/SPM-Compatible-blue)](https://swift.org/package-manager/) [![Cocoapod Platform](https://img.shields.io/badge/platform-iOS-blue.svg)](https://github.com/rbaumbach/Capsule) ![iOS Deployment Target](https://img.shields.io/badge/iOS_Deployment_Target-12.0-964B00) [![License](https://img.shields.io/dub/l/vibe-d.svg)](https://github.com/rbaumbach/Capsule/blob/master/MIT-LICENSE.txt)

A collection of Swift iOS protocols and wrappers for native iOS libraries and frameworks.

## What this means

This project contains many protocols, extensions, wrappers, property wrappers, errors, and builders that can be used with accompanying fakes for simple unit testing and misc. usage.

## Adding Capsule to your project

### CocoaPods

[CocoaPods](http://cocoapods.org) is the recommended way to add `Capsule` to your project:

1.  Add Capsule to your Podfile `pod 'Capsule'`.
2.  Install the pod(s) by running `pod install`.

### Swift Package manager

[Swift Package Manager](https://swift.org/package-manager/) can be used to add `Capsule` the to your project:

1.  Add `.package(url: "https://github.com/rbaumbach/Capsule", from: "1.5.0")`
2.  [Follow intructions to add](https://swift.org/getting-started/#using-the-package-manager) the Capsule package to your project.

### Clone from Github

1.  Clone repository from github and copy files directly, or add it as a git submodule.
2.  Add all files from `Source` directory to your project.

## Building

* Prerequisites: [ruby](https://github.com/sstephenson/rbenv), [ruby gems](https://rubygems.org/pages/download), [bundler](http://bundler.io)

This project has been setup to use [fastlane](https://fastlane.tools) to run the specs.

First, bundle required gems and then install Cocoapods when in the project directory:

```bash
$ bundle
$ bundle exec pod install
```

And then use fastlane to run all the specs on the command line:

```bash
$ bundle exec fastlane build
```

## Suggestions, requests, and feedback

Thanks for checking out `Capsule`.  Any feedback, suggestions and feedback can be can be sent to: github@ryan.codes, or opened as a github issue.
