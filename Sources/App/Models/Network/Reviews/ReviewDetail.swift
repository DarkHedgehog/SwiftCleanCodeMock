//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 27.03.2023.
//

import Foundation
import Vapor

struct ReviewDetail: Content {
    var id: UUID
    var product: Product
    var user: UserRecord
    var stars: Int
    var text: String
}
