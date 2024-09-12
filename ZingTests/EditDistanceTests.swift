//
//  EditDistanceTests.swift
//  ZingTests
//
//  Created by Andres Kievsky on 9/9/2024.
//

import XCTest
@testable import Zing

class EditDistanceTests: XCTestCase {
    let calculate = Scorer.calculateEditDistance

    func testEmptyStringWithNonEmptyString() {
        XCTAssertEqual(Scorer.calculateEditDistance("", "non-empty"), 9)
        XCTAssertEqual(Scorer.calculateEditDistance("non-empty", ""), 9)
    }

    func testLargerStrings() {
        let s1 = String(repeating: "a", count: 100)
        let s2 = String(repeating: "b", count: 1000)
        let result = Scorer.calculateEditDistance(s1, s2)
        XCTAssertEqual(result, 1000)
    }

    func testEmptyStrings() {
        XCTAssertEqual(Scorer.calculateEditDistance("", ""), 0)
    }

    func testSameStrings() {
        XCTAssertEqual(Scorer.calculateEditDistance(" ", " "), 0)
        XCTAssertEqual(Scorer.calculateEditDistance("a", "a"), 0)
        XCTAssertEqual(Scorer.calculateEditDistance("hello", "hello"), 0)
    }

    func testDifferentShortStrings() {
        XCTAssertEqual(Scorer.calculateEditDistance("abc", "def"), 3)
    }

    func testLongerStrings() {
        XCTAssertEqual(Scorer.calculateEditDistance("abcdefghij", "klmnopqrstuvwx"), 14)
    }

    func testOneCharacterDifference() {
        XCTAssertEqual(Scorer.calculateEditDistance("a", "b"), 1)
    }

    func testMultipleCharacterDifferences() {
        XCTAssertEqual(Scorer.calculateEditDistance("abcd", "efgh"), 4)
    }

    func testReverseStrings() {
        XCTAssertEqual(Scorer.calculateEditDistance("hello", "olleh"), 4)
    }

    func testWhitespaceAndSpecialCharacters() {
        XCTAssertEqual(Scorer.calculateEditDistance("Hello World!", "HELLO WORLD!"), 8)
    }
}
