//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 16.03.2023.
//

import Fluent
import Vapor

final class Product: Model, Content {
    static let schema = "products"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "cost")
    var cost: Double

    init() { }

    init(id: UUID? = nil, name: String, cost: Double) {
        self.id = id
        self.name = name
        self.cost = cost
    }
}
