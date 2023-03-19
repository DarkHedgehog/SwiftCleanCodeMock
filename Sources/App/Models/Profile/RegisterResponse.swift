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
    var user: UserRecord?
    var user_message: String?
    var error_message: String?
}
