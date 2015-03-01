# -*- coding: utf-8 -*-
Pod::Spec.new do |s|
  s.name         = "SwiftRegex"
  s.version      = "1.3.1"
  s.summary      = "A simple Swift NSRegularExpression library"

  s.ios.deployment_target = "8.1"
  s.osx.deployment_target = "10.10"

  s.description  = <<-DESC
SwiftRegex is a simple wrapper around the Foundation NSRegularExpression API.
It provides the following methods:

* `test()` -- checks to see if the passed-in string matches the regex.
* `match()` -- returns an array of Match structs, each containing
  one match of the regex against the target string. Each match contains
  a number of subgroups, if any were present in the regex.
* `replace()` -- wraps the NSRegularExpression string-replacement API.

The Regex struct also conforms to `StringLiteralConvertible` for easy creation.
                   DESC

  s.homepage     = "http://github.com/wjk/SwiftRegex"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author    = "William Kent"

  s.source       = { :git => "https://github.com/wjk/SwiftRegex.git", :tag => s.version.to_s }
  s.source_files  = "SwiftRegex/*.swift"
  s.requires_arc  = true
end
