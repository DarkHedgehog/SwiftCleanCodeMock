//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 19.03.2023.
//

import Foundation
import Vapor

struct LoginRequest: Content {
    var username: String
    var password: String
}
