//
//  CheckEnvironment.swift
//  Zing
//
//  Created by Andres Kievsky on 9/9/2024.
//

import AppKit
import Foundation

// LaunchServices provides LSCopyAllApplicationURLs
@_silgen_name("_LSCopyAllApplicationURLs") func LSCopyAllApplicationURLs(_: UnsafeMutablePointer<NSMutableArray?>) -> OSStatus;

class Env {
    func allApplications() -> [URL] {
        var apps: NSMutableArray?
        let result = LSCopyAllApplicationURLs(&apps)
        if result != 0 {
            return []
        }
        return apps as? Array<URL> ?? []
    }
    func execute(_ item: URL) {
        let configuration = NSWorkspace.OpenConfiguration()
        configuration.activates = true
        NSWorkspace.shared.openApplication(at: item, configuration: configuration)
    }
}
