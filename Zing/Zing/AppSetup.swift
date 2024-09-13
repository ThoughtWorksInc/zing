//
//  AppSetup.swift
//  Zing
//
//  Created by Andres Kievsky on 2/9/2024.
//

import AppKit

class ZingAppDelegate: NSObject, NSApplicationDelegate {
    let recognizerInstaller = RecognizerInstaller()
    func applicationDidFinishLaunching(_ notification: Notification) {
        guard let window = NSApplication.shared.windows.first else { return }
        window.styleMask = .borderless
        window.styleMask.remove(.resizable)
        recognizerInstaller.install()
    }
}

struct RecognizerInstaller {
    let recognizer = Recognizer()
    func install() {
        recognizer.setup {
            Task {
                await AppActivationAction().pressed()
            }
        }
    }
}
