//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 13.03.2023.
//

import Foundation
import Vapor

struct ReviewDeleteRequest: Content {
    var userId: UUID
    var reviewId: UUID
}
