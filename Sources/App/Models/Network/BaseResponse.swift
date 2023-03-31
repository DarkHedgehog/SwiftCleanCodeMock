//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 29.03.2023.
//

import Foundation
import Vapor

protocol BaseResponse: Content {
    associatedtype ValueWrapper: Content
    var result: Int { get set }
    var user_message: String? { get set }
    var error_message: String? { get set }
    var data: ValueWrapper? { get set }
}
