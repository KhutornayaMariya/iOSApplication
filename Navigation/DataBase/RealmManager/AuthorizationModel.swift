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

    init() {
//        migrate()
//        deleteCredential()
        refreshDatabase()
    }

    var credential: Credential?

    private func refreshDatabase() {
        let realm = try! Realm()
        credential = realm.objects(Credential.self).first
    }

    func addCredential(login: String, password: String) {
        let realm = try! Realm()
        try! realm.write {
            let credential = Credential()
            credential.password = password
            credential.login = login
            realm.add(credential)
        }
        refreshDatabase()
        print("Saved")
    }

    func deleteCredential() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        print("deleteAll")
    }

//    private func migrate() {
//        let config = Realm.Configuration(schemaVersion: 1)
//        Realm.Configuration.defaultConfiguration = config
//    }
}
