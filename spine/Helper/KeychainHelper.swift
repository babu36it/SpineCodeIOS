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
    
    func read(forKey key: String) -> Data? {
        
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
    
    func save<T>(_ item: T, forKey key: String) where T: Codable {
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)
            save(data, forKey: key)
            
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
        }
    }
    
    func read<T>(forKey key: String, type: T.Type) -> T? where T : Codable {
        
        // Read item data from keychain
        guard let data = read(forKey: key) else {
            return nil
        }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
}
