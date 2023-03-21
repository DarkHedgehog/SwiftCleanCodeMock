//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 20.03.2023.
//

import Foundation
import Vapor

class ProfileController {
    func register(_ req: Request) async throws -> RegisterResponse {
        guard let body = try? req.content.decode(RegisterRequest.self) else {
            throw Abort(.badRequest)
        }
        let shopDb = ShopDatabase.shared

        let alreadyRegisteredUser = try await shopDb.userByName(body.username, db: req.db)

        guard alreadyRegisteredUser == nil else {
            return RegisterResponse(
                result: -1,
                error_message: "Пользователь уже зарегестрирован"
            )
        }

        let registerUser = UserRecord(
            balance: 100,
            username: body.username,
            password: body.password,
            email: body.email,
            gender: body.gender,
            credit_card: body.credit_card,
            bio: body.bio)

        try await registerUser.save(on: req.db)

        let response = RegisterResponse(
            result: 1,
            user: registerUser,
            user_message: "Регистрация прошла успешно!",
            error_message: nil
        )

        return response
    }

    func update(_ req: Request) async throws -> ProfileUpdateResponse {
        guard let body = try? req.content.decode(ProfileUpdateRequest.self) else {
            throw Abort(.badRequest)
        }
        let shopDb = ShopDatabase.shared

        guard let existsUser = try await shopDb.userById(body.id, db: req.db) else {
            return ProfileUpdateResponse(
                result: -1,
                error_message: "User not found"
            )
        }

        existsUser.password = body.password
        existsUser.username = body.username
        existsUser.email = body.email
        existsUser.gender = body.gender
        existsUser.credit_card = body.credit_card
        existsUser.bio = body.bio

        try await existsUser.save(on: req.db)

        let response = ProfileUpdateResponse(
            result: 1,
            user: existsUser,
            user_message: "Update done",
            error_message: nil
        )

        return response
    }

    func getProfile(_ req: Request) async throws -> ProfileReadResponse {
        guard let body = try? req.content.decode(ProfileReadRequest.self) else {
            throw Abort(.badRequest)
        }
        let shopDb = ShopDatabase.shared

        guard let existsUser = try await shopDb.userById(body.id, db: req.db) else {
            return ProfileReadResponse(
                result: -1,
                error_message: "User not found"
            )
        }

        let response = ProfileReadResponse(
            result: 1,
            user: existsUser,
            user_message: "Profile info",
            error_message: nil
        )

        return response
    }
}
