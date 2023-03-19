//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 20.03.2023.
//

import Foundation
import Vapor

struct ProfileUpdateRequest: Content {
    var id: UUID
    var username: String
    var password: String
    var email: String
    var gender: String
    var credit_card: String
    var bio: String
}
