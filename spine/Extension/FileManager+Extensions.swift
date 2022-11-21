//
//  FileManager+Extensions.swift
//  spine
//
//  Created by Mac on 19/11/22.
//

import Foundation

extension FileManager {
    func saveDataToCachesDirectory(_ data: Data, filename: String) {
        if let cacheDirectory: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let fileURL = cacheDirectory.appendingPathComponent(filename)
            try? data.write(to: fileURL)
        }
    }
    
    func fileDataFromCachesDirectory(for filename: String) -> Data? {
        if let cacheDirectory: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let fileURL = cacheDirectory.appendingPathComponent(filename)
            return try? Data(contentsOf: fileURL)
        }
        return nil
    }
}

