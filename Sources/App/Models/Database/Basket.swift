//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 16.03.2023.
//

import Fluent
import Vapor

final class Basket: Model, Content {
    static let schema = "basket"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "userId")
    var userId: UUID

    @Field(key: "productId")
    var productId: UUID

    init() { }

    init(id: UUID? = nil, userId: UUID, productId: UUID) {
        self.id = id
        self.userId = userId
        self.productId = productId
    }
}
