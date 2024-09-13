//
//  B.swift
//  Zing
//
//  Created by Andres Kievsky on 2/9/2024.
//

import CoreGraphics
import Foundation

import Carbon.HIToolbox.Events

final class Recognizer {
    var observer: Any? = nil

    func setup(_ action: @escaping () -> Void) {
        let identifier = CGSKeyboardShortcut.Identifier(0xCAFEBEBE)
        let keyCode = CGKeyCode(kVK_Space)
        let shortCut = try? CGSKeyboardShortcut(identifier: identifier,
                            keyCode: keyCode,
                            modifierFlags: [.maskCommand, .maskControl],
                            acquisitionPolicy: .exclusivelyIfPossible)

        guard let shortCut else {
            print("Could not get the shortcut!")
            return
        }

        let pressedNotification = Notification.Name("CGSKeyboardShortcut.pressedNotification")
        // An opaque object to act as the observer. Notification center strongly holds this return value until you remove the observer registration.
        

        self.observer = NotificationCenter.default.addObserver(forName: pressedNotification,
                                                       object: shortCut,
                                                       queue: nil,
                                                       using: { _ in action() })
    }
}
