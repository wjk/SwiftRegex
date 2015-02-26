//
//  BlockReplacementTests.swift
//  SwiftRegex
//
//  Created by William Kent on 2/26/15.
//  Copyright (c) 2015 William Kent. All rights reserved.
//

import Foundation
import XCTest
import SwiftRegex

class BlockReplacementTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimpleReplacement() {
        let input = "Hello, playground!"
        let expectedOutput = "Hello, World!"
        let regex = Regex("playground")
        let result = regex.replace(input, withBlock: {
            (match) -> String in
            return "World"
        })
        
        if let result = result {
            XCTAssertEqual(expectedOutput, result, "Simple regex replace returned unexpected value")
        } else {
            XCTFail("regex.replace() returned nil")
        }
    }
    
    func testMultipleReplacement() {
        let input = "Would you like a bear on your head?"
        let expectedOutput = "Would you moose a moose on moose moose?"
        let regex = Regex("\\b[^\\s]{4}\\b")
        let result = regex.replace(input, withBlock: {
            (match) -> String in
            return "moose"
        })
        
        if let result = result {
            XCTAssertEqual(expectedOutput, result, "Multiple regex replace returned unexpected value")
        } else {
            XCTFail("regex.replace() returned nil")
        }
    }
    
    func testComplexReplacement() {
        let input = "Would you like a bear on your head?"
        let expectedOutput = "5 3 4 1 4 2 4 5"
        let regex = Regex("[^\\s]+")
        let result = regex.replace(input, withBlock: {
            (match) -> String in
            if let text = match.entireMatch {
                return "\(count(text))"
            } else {
                return "0"
            }
        })
        
        if let result = result {
            XCTAssertEqual(expectedOutput, result, "Complex regex replace returned unexpected value")
        } else {
            XCTFail("regex.replace() returned nil")
        }
    }
}
