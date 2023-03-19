//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 19.03.2023.
//

import Foundation
import Vapor
import FluentKit

final class ShopDatabase {
    static var shared = ShopDatabase()

    private init () {
    }

    public func userByName(_ userName: String, db: Database) async throws -> UserRecord? {
        guard
            !userName.isEmpty,
            let user = try await UserRecord.query(on: db).filter(\.$username == userName).first() else {
            return nil
        }

        return user
    }

    public func userByName(_ userName: String, password: String, db: Database) async throws -> UserRecord? {
        guard
            !userName.isEmpty,
            let user = try await UserRecord.query(on: db)
                .filter(\.$username == userName)
                .filter(\.$password == password)
                .first() else {
            return nil
        }

        return user
    }
}
