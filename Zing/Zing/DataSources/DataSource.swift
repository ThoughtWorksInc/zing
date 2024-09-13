//
//  DataSource.swift
//  Zing
//
//  Created by Andres Kievsky on 10/9/2024.
//

import Foundation

struct DataSource {
    
}

protocol Item {
    
}

struct FilesystemItem : Item {
    let url: URL
}
