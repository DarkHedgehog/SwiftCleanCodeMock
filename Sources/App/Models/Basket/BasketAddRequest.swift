//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 16.03.2023.
//

import Foundation
import Vapor

struct BasketAddRequest: Content {
    var productId: UUID
}
