//
//  ZingModel.swift
//  Zing
//
//  Created by Andres Kievsky on 3/9/2024.
//

import Foundation
import SwiftData

class ZingModel {
    func createModelContainer() -> ModelContainer {
        let schema = Schema([
            DeletemeItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}

@Model
final class DeletemeItem {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
