//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 13.03.2023.
//

import Foundation
import Vapor

struct ReviewsListResponse: Content {
    var result: Int
    var error_message: String?
    var productId: UUID?
    var reviews: [ReviewDetail]?
}
