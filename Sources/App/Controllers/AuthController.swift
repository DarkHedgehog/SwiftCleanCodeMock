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

        let registerUser = UserRecord(
            balance: 100,
            username: body.username,
            password: body.username,
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
}
