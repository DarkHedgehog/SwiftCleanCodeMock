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
        payBasket.group(":userID") { user in
            user.post(use: basketPayProducts)
        }
    }

    func basketForUser(req: Request) async throws -> BasketReadResponse {
        guard
            let uuidString = req.parameters.get("userID"),
            let userId: UUID = UUID(uuidString: uuidString) else {
            throw Abort(.notFound)
        }

        let shopDb = ShopDatabase.shared

        let basket = try await shopDb.basketForUser(userId, db: req.db)

        return BasketReadResponse(result: 1, data: basket)
    }

    func basketAddProduct (req: Request) async throws -> BasketReadResponse {
        let shopDb = ShopDatabase.shared
        var product: Product?

        do {
            let productIdRequest = try req.content.decode(BasketAddRequest.self)
            product = try await shopDb.productById(productIdRequest.productId, db: req.db)
        } catch {
            return BasketReadResponse(result: -1, error_message: "Product not found")
        }

        guard
            let uuidString = req.parameters.get("userID"),
            let productId = product?.id,
            let userId: UUID = UUID(uuidString: uuidString) else {
            return BasketReadResponse(result: -1, error_message: "Data not found")
        }

        let _ = try await shopDb.basketAddProduct(userId: userId, productId: productId, db: req.db)

        return try await basketForUser(req: req)
    }

    func basketPayProducts(req: Request) async throws -> BasketReadResponse {
        let shopDb = ShopDatabase.shared

        do {
            let signRequest = try req.content.decode(BasketPayForAllRequest.self)
            if signRequest.sign != "i swear" {
                return BasketReadResponse(result: -2, error_message: "Incorrect sign")
            }
        } catch {
            return BasketReadResponse(result: -1, error_message: "Product not found")
        }

        guard
            let uuidString = req.parameters.get("userID"),
            let userId: UUID = UUID(uuidString: uuidString),
            let _ = try await UserRecord.query(on: req.db).filter(\.$id == userId).first() else {
            throw Abort(.notFound)
        }

        _ = try await shopDb.payForAll(userId: userId, db: req.db)

        return try await basketForUser(req: req)
    }
}
