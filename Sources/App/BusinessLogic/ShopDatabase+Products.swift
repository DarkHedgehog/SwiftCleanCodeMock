//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 30.03.2023.
//

import Foundation
import FluentKit

extension ShopDatabase {
    public func productById(_ id: UUID, db: Database) async throws -> Product? {
        guard
            let product = try await Product.query(on: db).filter(\.$id == id).first() else {
            return nil
        }

        return product
    }
}
