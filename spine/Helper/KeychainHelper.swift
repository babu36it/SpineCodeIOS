//
//  KeychainHelper.swift
//  spine
//
//  Created by Mac on 18/11/22.
//

import Foundation

final class KeychainHelper {
    
    static let shared = KeychainHelper()
    
    private let bundleId: String
    
    init() {
        self.bundleId = Bundle.main.bundleIdentifier ?? "com.spiritualnetwork.spin"
    }
    
    func save(_ data: Data, forKey key: String) {
        
        let query = [
            kSecValueData: data,
            kSecAttrService: key,
            kSecAttrAccount: bundleId,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            // Item already exist, thus update it.
            let query = [
                kSecAttrService: key,
                kSecAttrAccount: bundleId,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            
            // Update existing item
            SecItemUpdate(query, attributesToUpdate)
        }
    }
    
    func readData(forKey key: String) -> Data? {
        
        let query = [
            kSecAttrService: key,
            kSecAttrAccount: bundleId,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    func delete(forKey key: String) {
        
        let query = [
            kSecAttrService: key,
            kSecAttrAccount: bundleId,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
}

extension KeychainHelper {
    func save<T: Codable>(_ item: T, forKey key: String) {
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)
            save(data, forKey: key)
            
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
        }
    }
    
    func read<T: Decodable>(forKey key: String) -> T? {
        
        // Read item data from keychain
        guard let data = readData(forKey: key) else {
            return nil
        }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(T.self, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
}
