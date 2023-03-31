//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 21.03.2023.
//

import Foundation
import Vapor

struct ProfileReadRequest: Content {
    var id: UUID
}
