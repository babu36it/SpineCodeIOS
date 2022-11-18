//
//  FileManager+Extensions.swift
//  spine
//
//  Created by Mac on 19/11/22.
//

import Foundation

extension FileManager {
    func saveDataToCachesDirectory(_ data: Data, filename: String) {
        if let cacheDirectory: String = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first {
            let filePath = cacheDirectory.appending("/\(filename)")
            try? data.write(to: URL(fileURLWithPath: filePath))
        }
    }
    
    func fileDataFromCachesDirectory(for filename: String) -> Data? {
        if let cacheDirectory: String = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first {
            let filePath = cacheDirectory.appending("/\(filename)")
            return FileManager.default.contents(atPath: filePath)
        }
        return nil
    }
}

