//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 13.03.2023.
//

import Foundation
import Vapor

struct ReviewDeleteResponse: Content {
    var id_review: Int
    var message: String
}
