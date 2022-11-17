//
//  AuthorizationModel.swift
//  Navigation
//
//  Created by m.khutornaya on 03.11.2022.
//

import Foundation
import RealmSwift

class Credential: Object {
    @Persisted var password: String = ""
    @Persisted var login: String = ""
}

class AuthorizationModel {
    static let defaultModel = AuthorizationModel()

    private var config:  Realm.Configuration  {
        Realm.Configuration(encryptionKey: getKey())
    }

    init() {
//        migrate()
//        deleteCredential()
        refreshDatabase()
    }

    var credential: Credential?

    private func refreshDatabase() {
        do {
            let realm = try Realm(configuration: config)
            credential = realm.objects(Credential.self).first
        } catch let error as NSError {
            fatalError("Error opening realm: \(error)")
        }
    }

    func addCredential(login: String, password: String) {
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                let credential = Credential()
                credential.password = password
                credential.login = login
                realm.add(credential)
            }
        } catch let error as NSError {
            fatalError("Error opening realm: \(error)")
        }
        refreshDatabase()
        print("Saved")
    }

    func deleteCredential() {
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            fatalError("Error opening realm: \(error)")
        }
        
        print("deleteAll")
    }

    private func getKey() -> Data {
        // Identifier for our keychain entry - should be unique for your application
        let keychainIdentifier = "io.Realm.EncryptionExampleKey"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        // First check in the keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
        // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            // swiftlint:disable:next force_cast
            return dataTypeRef as! Data
        }
        // No pre-existing key from this application, so generate a new one
        // Generate a random encryption key
        var key = Data(count: 64)
        key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
            let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
            assert(result == 0, "Failed to get random bytes")
        })
        // Store the key in the keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: key as AnyObject
        ]
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        return key
    }

    //    private func migrate() {
    //        let config = Realm.Configuration(schemaVersion: 1)
    //        Realm.Configuration.defaultConfiguration = config
    //    }
}
