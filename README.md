# SwiftRegex

This library provides a small, simple interface to the Cocoa
`NSRegularExpression` class. As it uses the Swift `Set<T>` class,
this library requires Swift 1.2 and Xcode 6.3 beta; it will not
compile using earlier versions of Xcode.

SwiftRegex is licensed under the [MIT license](LICENSE.md).

## Installation

SwiftRegex can be installed through [CocoaPods](http://cocoapods.org).
Note that, while the pod is marked as OS X-only, SwiftRegex should also
work on iOS. However, I cannot currently mark the pod as iOS-compatible
because I do not have an iOS code signing certificate, which is now
required by Xcode when building a framework even when it is not for release.
