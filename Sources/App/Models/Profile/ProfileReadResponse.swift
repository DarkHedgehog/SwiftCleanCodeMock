//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 21.03.2023.
//

import Foundation
import Vapor

struct ProfileReadResponse: Content {
    var result: Int
    var user: UserRecord?
    var user_message: String?
    var error_message: String?
}

