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
        products.group(":productID") { product in
            product.delete(use: delete)
            product.get(use: productById)
        }
    }

    func list(req: Request) async throws -> [Product] {
        let products = try await Product.query(on: req.db).all()
        return products
    }

    func productById(req: Request) async throws -> ProductDetailResponse {
        let shopDb = ShopDatabase.shared

        guard
            let uuidString = req.parameters.get("productID"),
            let productId: UUID = UUID(uuidString: uuidString),
            let product = try await shopDb.productById(productId, db: req.db) else {
            throw Abort(.notFound)
        }

        return ProductDetailResponse(result: 1, error_message: nil, product: product)
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

