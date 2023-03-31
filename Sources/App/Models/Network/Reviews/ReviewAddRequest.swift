//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 13.03.2023.
//

import Foundation
import Vapor

struct ReviewAddRequest: Content {
    var userId: UUID
    var productId: UUID
    var stars: Int
    var text: String
}
