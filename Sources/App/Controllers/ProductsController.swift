//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 16.03.2023.
//

import Fluent
import Vapor

struct ProductsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.get(use: list)
        products.post(use: create)
        products.group(":productID") { todo in
            todo.delete(use: delete)
        }
    }

    func list(req: Request) async throws -> [Product] {
        let products = try await Product.query(on: req.db).all()
        return products
    }

    func create(req: Request) async throws -> Product {
        let product = try req.content.decode(Product.self)
        try await product.save(on: req.db)
        return product
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let product = try await Todo.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await product.delete(on: req.db)
        return .noContent
    }
}

