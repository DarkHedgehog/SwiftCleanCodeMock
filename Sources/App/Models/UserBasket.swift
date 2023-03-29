//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 29.03.2023.
//

import Foundation
import Vapor

struct UserBasket: Content {
    let userId: UUID
    let product: [Product]
    let totalCost: Double
    let balance: Double
}
