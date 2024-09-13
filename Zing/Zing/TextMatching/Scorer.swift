//
//  Scorer.swift
//  Zing
//
//  Created by Andres Kievsky on 9/9/2024.
//

import Foundation

struct StringAndScore : Equatable {
    let string: String
    let score: Int
    init(_ string: String, _ score: Int) {
        self.string = string
        self.score = score
    }
}

struct Scorer {
    let name: String
    let score: (String, String) -> Int
    
    // Based on Fuzzy Wuzzy https://github.com/botfront/fuzzy-matcher/blob/master/README.md
    static func partialDistance(val1: String, val2: String) -> Int {
        let values = [val1, val2].sorted { $0.count > $1.count }
        let (longer, shorter) = (values[0], values[1])
        var distances = [Int]()
        
        for i in 0...longer.count - shorter.count {
            let startIndex = longer.index(longer.startIndex, offsetBy: i)
            let endIndex = longer.index(startIndex, offsetBy: shorter.count)
            let substring = String(longer[startIndex..<endIndex])
            distances.append(calculateEditDistance(shorter, substring))
        }
        
        return distances.min() ?? 0
    }

    static func calculateRatio(_ val1: String, _ val2: String) -> Int {
        let maxDistance = max(val1.count, val2.count)
        let dist = calculateEditDistance(val1, val2)
        return Int(100 * (1 - Double(dist) / Double(maxDistance)))
    }

    static func calculatePartialRatio(val1: String, val2: String) -> Int {
        let maxDistance = val1.count
        let pdist = partialDistance(val1: val1, val2: val2)
        return Int(100 * (1 - Double(pdist) / Double(maxDistance)))
    }
    
    // Note: this simple method has s1.len * s2.len complexity
    static func calculateEditDistance(_ s1: String, _ s2: String) -> Int {
            // Handle the case where one or both strings are empty
            if s1.isEmpty {
                return s2.count
            }
            if s2.isEmpty {
                return s1.count
            }

            // Convert strings to arrays of characters
            let s1Chars = Array(s1)
            let s2Chars = Array(s2)
            
            let len1 = s1Chars.count
            let len2 = s2Chars.count
            
            // Create a 2D array to store the distances
            var dp = Array(repeating: Array(repeating: 0, count: len2 + 1), count: len1 + 1)
            
            // Initialize the first row and column of the array
            for i in 0...len1 {
                dp[i][0] = i
            }
            for j in 0...len2 {
                dp[0][j] = j
            }
            
            // Fill the dp array
            for i in 1...len1 {
                for j in 1...len2 {
                    let cost = s1Chars[i - 1] == s2Chars[j - 1] ? 0 : 1
                    dp[i][j] = min(
                        dp[i - 1][j] + 1,  // Deletion
                        dp[i][j - 1] + 1,  // Insertion
                        dp[i - 1][j - 1] + cost // Substitution
                    )
                }
            }
            
            return dp[len1][len2]
        }

    enum Algorithms {
        static let ratio = Scorer(name: "Ratio", score: calculateRatio)
        static let partialRatio = Scorer(name: "Partial Ratio", score: calculatePartialRatio)
        static let all = [ratio, partialRatio]
    }
    
    static func match(value: String, choices: [String] = [], scorer: Scorer, limit: Int = 5) -> [StringAndScore] {
        let distances = choices.map { choice in
            StringAndScore(choice, scorer.score(value, choice))
        }
        
        let sortedDistances = distances.sorted { $0.score > $1.score }
        return Array(sortedDistances.prefix(limit))
    }
}
