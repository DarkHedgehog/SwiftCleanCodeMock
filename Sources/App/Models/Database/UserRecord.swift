//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 09.03.2023.
//

import Fluent
import Vapor

final class UserRecord: Model, Content {
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String

    @Field(key: "password")
    var password: String

    @Field(key: "email")
    var email: String

    @Field(key: "gender")
    var gender: String

    @Field(key: "credit_card")
    var credit_card: String

    @Field(key: "bio")
    var bio: String

    @Field(key: "balance")
    var balance: Double

    init() { }
    
    init(
        id: UUID? = nil,
        balance: Double,
        username: String,
        password: String,
        email: String,
        gender: String,
        credit_card: String,
        bio: String) {
            self.id = id
            self.balance = balance
            self.username = username
            self.password = password
            self.email = email
            self.gender = gender
            self.credit_card = credit_card
            self.bio = bio
        }
}
