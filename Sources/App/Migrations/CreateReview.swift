//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 27.03.2023.
//

import Fluent

struct CreateReview: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("reviews")
            .id()
            .field("userId", .uuid, .required)
            .field("productId", .uuid, .required)
            .field("stars", .int, .required)
            .field("text", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("reviews").delete()
    }
}
