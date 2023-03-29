//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 13.03.2023.
//

import Foundation
import Vapor

struct ReviewDeleteResponse: Content {
    var result: Int
    var reviewId: UUID
    var error_message: String?
    var message: String?
}
