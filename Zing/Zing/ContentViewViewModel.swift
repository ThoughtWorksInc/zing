//
//  ContentViewViewModel.swift
//  Zing
//
//  Created by Andres Kievsky on 3/9/2024.
//

import AppKit

class ContentViewViewModel: ObservableObject {
    func acceptPressed() {
        DispatchQueue.main.async {
            NSApplication.shared.hide(nil)
        }
    }
    func rejectPressed() {
        DispatchQueue.main.async {
            NSApplication.shared.hide(nil)
        }
    }
}
