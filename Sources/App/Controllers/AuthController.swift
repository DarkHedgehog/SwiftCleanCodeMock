//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 09.03.2023.
//

import Foundation
import Vapor

class AuthController {
    
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
            id_user: registerUser.id,
            balance: registerUser.balance,
            user_message: "Регистрация прошла успешно!",
            error_message: nil
        )

        return response
    }

    func login(_ req: Request) async throws -> LoginResponse {
        guard let body = try? req.content.decode(LoginRequest.self) else {
            throw Abort(.badRequest)
        }

        let shopDb = ShopDatabase.shared

        guard let user = try await shopDb.userByName(body.username, password:body.password, db: req.db) else {
            return LoginResponse(result: -1, error_message: "User not found")
        }

        return LoginResponse(result: 1, user: user, user_message: "Ok")
    }

}
