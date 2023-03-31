//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 20.03.2023.
//

import Foundation
import Vapor

struct ProfileUpdateResponse: Content {
    var result: Int
    var user: UserRecord?
    var user_message: String?
    var error_message: String?
}
