//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 27.03.2023.
//

import Foundation
import Vapor

struct ProductDetailResponse: Content {
    var result: Int
    var error_message: String?
    var product: Product?
}
