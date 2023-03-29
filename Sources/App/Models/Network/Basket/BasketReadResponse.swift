//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 29.03.2023.
//

import Foundation
import Vapor

struct BasketReadResponse: BaseResponse {
    var result: Int
    var user_message: String?
    var error_message: String?
    var data: UserBasket?    
}
