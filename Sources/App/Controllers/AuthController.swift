//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 09.03.2023.
//

import Foundation
import Vapor

class AuthController {
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
