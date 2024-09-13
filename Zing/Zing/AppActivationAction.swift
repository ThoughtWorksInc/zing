//
//  AppActivationAction.swift
//  Zing
//
//  Created by Andres Kievsky on 2/9/2024.
//

import Foundation
import AppKit

class AppActivationAction {
    @MainActor func pressed() {
        NSApp.activate(ignoringOtherApps: true)
    }
}
