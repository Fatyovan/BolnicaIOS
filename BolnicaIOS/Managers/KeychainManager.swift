//
//  KeychainManager.swift
//  BolnicaIOS
//
//  Created by Ivan Jovanovik on 16/03/2024.
//

import Foundation

class KeychainManager {
    
    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    static func saveLoginToken(
        service: String,
        account: String,
        userObject: AuthenticatedUser
    ) throws {
        let userDict = AppUtils.shared.encode(object: userObject)
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: userDict as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateEntry
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
    }
    
    static func getLoginData(
        service: String,
        account: String
    ) throws -> AuthenticatedUser? {
        
        do {
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service as AnyObject,
                kSecAttrAccount as String: account as AnyObject,
                kSecReturnData as String: kCFBooleanTrue,
                kSecMatchLimit as String: kSecMatchLimitOne
            ]
            
            var result: AnyObject?
            let status = SecItemCopyMatching(query as CFDictionary, &result)
            
            guard status == errSecSuccess else {
                throw KeychainError.unknown(status)
            }
            
            guard let userData = result as? Data else {
                return nil
            }
            
            let decoder = JSONDecoder()
            let userObject = try decoder.decode(AuthenticatedUser.self, from: userData)
            return userObject
            
        } catch {
            throw error
        }
    }
    
    static func deleteAllData() throws {
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword
            ]
            
            let status = SecItemDelete(query as CFDictionary)
            
            guard status == errSecSuccess || status == errSecItemNotFound else {
                throw KeychainError.unknown(status)
            }
        }
}
