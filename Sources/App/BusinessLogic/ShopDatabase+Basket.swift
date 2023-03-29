//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 30.03.2023.
//

import Foundation
import FluentKit

extension ShopDatabase {

    public func basketForUser(_ userId: UUID, db: Database) async throws -> UserBasket? {
        guard
            let user = try await userById(userId, db: db) else {
            return nil
        }

        let productIds = try await Basket.query(on: db).filter( \.$userId == userId).all(\.$productId)
        let products = try await Product.query(on: db).filter(\.$id ~~ productIds).all()
        let totalCost = products.reduce(0.0) {
            $0 + $1.cost
        }

        let basket = UserBasket(
            userId: userId,
            product: products,
            totalCost: totalCost,
            balance: user.balance
        )

        return basket
    }

    public func basketAddProduct(userId: UUID, productId: UUID, db: Database) async throws -> Basket? {
        guard
            let _ = try await userById(userId, db: db) else {
            return nil
        }
        let basketItem = Basket(userId: userId, productId: productId)
        try await basketItem.save(on: db)

        return basketItem
    }
}
