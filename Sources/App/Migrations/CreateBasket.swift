//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 16.03.2023.
//

import Fluent

struct CreateBasket: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("basket")
            .id()
            .field("userId", .uuid, .required)
            .field("productId", .uuid, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("basket").delete()
    }
}
