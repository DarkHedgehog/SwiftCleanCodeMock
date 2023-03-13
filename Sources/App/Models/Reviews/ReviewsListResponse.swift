//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 13.03.2023.
//

import Foundation
import Vapor

struct ReviewsListResponse: Content {
    var id_product: Int
    var reviews: [Review]
}
