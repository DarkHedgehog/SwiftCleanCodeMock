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

    public func userById(_ id: UUID, db: Database) async throws -> UserRecord? {
        guard
            let user = try await UserRecord.query(on: db).filter(\.$id == id).first() else {
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

    public func productById(_ id: UUID, db: Database) async throws -> Product? {
        guard
            let product = try await Product.query(on: db).filter(\.$id == id).first() else {
            return nil
        }

        return product
    }

    public func reviewsByProductId(_ id: UUID, db: Database) async throws -> [Review]? {
        guard
            let _ = try await productById(id, db: db) else {
            return nil
        }

        let reviews = try await Review.query(on: db).filter(\.$productId == id).all()    

        return reviews
    }

    public func reviewById(_ id: UUID, db: Database) async throws -> Review? {
        guard
            let review = try await Review.query(on: db).filter(\.$id == id).first() else {
            return nil
        }
        return review
    }
}
