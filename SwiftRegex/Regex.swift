//
//  Regex.swift
//  Cupertino
//
//  Created by William Kent on 2/19/15.
//  Copyright (c) 2015 William Kent. All rights reserved.
//

import Foundation

public enum RegexFlags {
    case CaseInsensitive
    case AllowCommentsAndWhitespace
    case IgnoreMetacharacters
    case DotMatchesLineSeparators
    case AnchorsMatchLines
    case UseUnicodeWordBoundaries
}

public struct Regex {
    public let pattern: String
    public let options: Set<RegexFlags>
    
    public init(pattern: String, options: Set<RegexFlags>) {
        self.pattern = pattern
        self.options = options
    }
    
    public init(pattern: String) {
        self.pattern = pattern
        self.options = []
    }
    
    private var matcherOptions: NSRegularExpressionOptions {
        get {
            var opts: NSRegularExpressionOptions = nil
            
            if options.contains(.CaseInsensitive) {
                opts |= .CaseInsensitive
            }
            if options.contains(.AllowCommentsAndWhitespace) {
                opts |= .AllowCommentsAndWhitespace
            }
            if options.contains(.IgnoreMetacharacters) {
                opts |= .IgnoreMetacharacters
            }
            if options.contains(.DotMatchesLineSeparators) {
                opts |= .DotMatchesLineSeparators
            }
            if options.contains(.AnchorsMatchLines) {
                opts |= .AnchorsMatchLines
            }
            if options.contains(.UseUnicodeWordBoundaries) {
                opts |= .UseUnicodeWordBoundaries
            }
            
            return opts
        }
    }
    
    private var matcher: NSRegularExpression? {
        get {
            return NSRegularExpression(pattern: self.pattern, options: self.matcherOptions, error: nil)
        }
    }
    
    public func test(string: String) -> Bool? {
        return test(string, options: nil)
    }
    
    public func test(string: String, options: NSMatchingOptions) -> Bool? {
        // This function returns true if the regex matches, false if the regex does
        // not match, or nil if there is a syntax error in the regex itself.
        if let matcher = matcher {
            return matcher.numberOfMatchesInString(string, options: options, range: NSMakeRange(0, string.utf16Count)) != 0
        } else {
            return nil
        }
    }
    
    public func match(string: String) -> [RegexMatch]? {
        return match(string, options: nil)
    }
    
    public func match(string: String, options: NSMatchingOptions) -> [RegexMatch]? {
        if let matcher = matcher {
            let cocoaMatches = matcher.matchesInString(string, options: options, range: NSMakeRange(0, string.utf16Count))
            var retval = [RegexMatch]()
            
            for match: AnyObject in cocoaMatches {
                if let match = match as? NSTextCheckingResult {
                    retval.append(RegexMatch(cocoaMatch: match, inString: string))
                }
            }
            
            return retval
        } else {
            return nil
        }
    }
    
    public func replace(string: String, withTemplate template: String) -> String? {
        return replace(string, options: nil, withTemplate: template)
    }
    
    public func replace(string: String, options: NSMatchingOptions, withTemplate template: String) -> String? {
        if let matcher = matcher {
            var workString = NSMutableString(string: string)
            matcher.replaceMatchesInString(workString, options: options, range: NSMakeRange(0, workString.length), withTemplate: template)
            let retval = workString as NSString
            return String(retval)
        }
        
        return nil
    }
}

extension Regex: StringLiteralConvertible {
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public typealias UnicodeScalarLiteralType = UnicodeScalar
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.pattern = "\(value)"
        self.options = []
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.pattern = value
        self.options = []
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.pattern = value
        self.options = []
    }
}
