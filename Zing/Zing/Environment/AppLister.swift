//
//  AppLister.swift
//  Zing
//
//  Created by Andres Kievsky on 9/9/2024.
//

import Foundation
import AppKit

struct AppLister {
    func listApps() -> [FilesystemItem]? {
        let urls : [URL] = Env().allApplications()
        return urls.map { url in
            return FilesystemItem(url: url)
        }
    }
}
