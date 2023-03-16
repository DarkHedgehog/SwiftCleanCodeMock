//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 16.03.2023.
//

import Fluent
import Vapor

struct BasketController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let basket = routes.grouped("basket")
        basket.group(":userID") { user in
            user.get(use: basketForUser)
            user.post(use: basketAddProduct)
        }

        let payBasket = routes.grouped("payBasket")
        basket.group(":userID") { user in
            user.post(use: basketPayProducts)
        }
    }

    func basketForUser(req: Request) async throws -> [Product] {
        guard
            let uuidString = req.parameters.get("userID"),
            let userId: UUID = UUID(uuidString: uuidString) else {
            throw Abort(.notFound)
        }

        let productIds = try await Basket.query(on: req.db).filter( \.$userId == userId).all(\.$productId)
        let products = try await Product.query(on: req.db).filter(\.$id ~~ productIds).all()

        return products
    }

    func basketAddProduct (req: Request) async throws -> [Product] {
        guard
            let uuidString = req.parameters.get("userID"),
            let userId: UUID = UUID(uuidString: uuidString) else {
            throw Abort(.notFound)
        }

        let productIdRequest = try req.content.decode(BasketAddRequest.self)
        let basketItem = Basket(userId: userId, productId: productIdRequest.productId)
        try await basketItem.save(on: req.db)

        return try await basketForUser(req: req)
    }

    func basketPayProducts(req: Request) async throws -> [Product] {
        guard
            let uuidString = req.parameters.get("userID"),
            let userId: UUID = UUID(uuidString: uuidString),
            let user = try await UserRecord.query(on: req.db).filter(\.$id == userId).first() else {
            throw Abort(.notFound)
        }

        let basket = try await Basket.query(on: req.db).filter( \.$userId == userId).all()
        let productIds = basket.map { $0.productId }
        let products = try await Product.query(on: req.db).filter(\.$id ~~ productIds).all()

        for item in basket {
            if let product = try await Product.query(on: req.db).filter(\.$id == item.productId).first() {
                user.balance -= product.cost
            }
            try await item.delete(on: req.db)
        }

        return try await basketForUser(req: req)
    }

}

