//
//  Item.swift
//  Zing
//
//  Created by Andres Kievsky on 2/9/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
