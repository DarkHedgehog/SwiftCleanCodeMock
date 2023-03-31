//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 13.03.2023.
//

import Fluent
import Vapor

final class Review: Model, Content {
    static let schema = "reviews"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "productId")
    var productId: UUID

    @Field(key: "userId")
    var userId: UUID

    @Field(key: "stars")
    var stars: Int

    @Field(key: "text")
    var text: String

    init () { }

    init(id: UUID? = nil, productId: UUID, userId: UUID, stars: Int, text: String) {
        self.id = id
        self.productId = productId
        self.userId = userId
        self.stars = stars
        self.text = text
    }
}
