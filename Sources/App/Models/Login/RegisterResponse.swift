//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 09.03.2023.
//

import Foundation
import Vapor

struct RegisterResponse: Content {
    var result: Int
    var id_user: UUID?
    var balance: Double?
    var user_message: String?
    var error_message: String?
}
