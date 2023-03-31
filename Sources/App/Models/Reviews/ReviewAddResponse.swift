//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 13.03.2023.
//

import Foundation
import Vapor

struct ReviewAddResponse: Content {
    var reviewId: UUID?
    var result: Int
    var error_message: String?
}
