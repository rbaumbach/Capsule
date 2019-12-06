# Capsule [![Bitrise](https://app.bitrise.io/app/e9b6e9645d7c5731/status.svg?token=9PaWYidx-KT_cmHr0mPagw&branch=master)](https://app.bitrise.io/app/e9b6e9645d7c5731) [![Cocoapod Version](https://img.shields.io/cocoapods/v/Capsule.svg)](https://github.com/rbaumbach/Capsule) [![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![SPM Compatible](https://img.shields.io/badge/SPM-Compatible-blue)](https://swift.org/package-manager/) [![Cocoapod Platform](https://img.shields.io/badge/platform-iOS-blue.svg)](https://github.com/rbaumbach/Capsule) [![License](https://img.shields.io/dub/l/vibe-d.svg)](https://github.com/rbaumbach/InstagramSimpleOAuth/blob/master/MIT-LICENSE.txt)

A collection of Swift iOS protocols and wrappers for native iOS libraries and frameworks.

## What this means

This project contains many protocols, wrappers, builders that can be used with accompanying fakes for simple unit testing.

## Adding Capsule to your project

### CocoaPods

[CocoaPods](http://cocoapods.org) is the recommended way to add Capsule to your project:

1.  Add Capsule to your Podfile `pod 'Capsule'`.
2.  Install the pod(s) by running `pod install`.

### Carthage

[Carthage](https://github.com/Carthage/Carthage) can be used to manually add the Capsule framework to your project:

1. Add `github "rbaumbach/Capsule"` to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile).
2. [Follow instructions to manually add](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) the Capsule framework to your project.

### Swift Package manager

[Swift Package Manager](https://swift.org/package-manager/) is another way to add the to your project:

1.  Add `.package(url: "https://github.com/rbaumbach/Capsule", from: "0.1.3")`
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

Thanks for checking out Capsule.  Any feedback, suggestions and feedback can be can be sent to: github@ryan.codes, or opened as a github issue.
