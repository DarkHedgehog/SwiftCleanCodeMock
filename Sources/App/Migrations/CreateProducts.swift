//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 16.03.2023.
//

import Fluent

struct CreateProduct: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(Product.schema)
            .id()
            .field("name", .string, .required)
            .field("cost", .double, .required)
            .create()

        try await Product(name: "Лопата", cost: 12.03).save(on: database)
        try await Product(name: "Мышка", cost: 2.23).save(on: database)
        try await Product(name: "Акции P&G", cost: 3.33).save(on: database)
        try await Product(name: "Урок GeekBrains", cost: 9.99).save(on: database)
    }

    func revert(on database: Database) async throws {
        try await database.schema(Product.schema).delete()
    }
}
