//
//  ScorerTests.swift
//  ScorerTests
//
//  Created by Andres Kievsky on 2/9/2024.
//

import XCTest
@testable import Zing

final class ScorerTests: XCTestCase {
    
    func testPartialDistance() {
        let query = "orange"
        let candidates = ["orangoutan", "orange tango", "olive martini", "orangemartinin", "martininorange"]
        
        let partialDistances = candidates.map { candidate in
            Scorer.partialDistance(val1: query, val2: candidate)
        }

        XCTAssertEqual(partialDistances, [1, 0, 5, 0, 0])
    }

    func testRatio() {
        let query = "orange"
        let values = ["blue", "orange", "brown", "ornage", "range", "angel", "gang", "ang"]
        
        let fuzzy = Scorer.match(value: query, choices: values, scorer: Scorer.Algorithms.ratio , limit: 3)
        
        XCTAssertEqual(fuzzy, [StringAndScore("orange", 100), StringAndScore("range", 83), StringAndScore("ornage", 66)])
    }

    func testPartialRatio() {
        let query = "orange"
        let values = ["blue tango", "orange tango", "brown tango"]
        
        let fuzzy = Scorer.match(value: query, choices: values, scorer: Scorer.Algorithms.partialRatio, limit: 3)
        
        assert(fuzzy == [StringAndScore("orange tango", 100), StringAndScore("blue tango", 50), StringAndScore("brown tango", 50)])
    }
}
