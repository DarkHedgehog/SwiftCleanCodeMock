//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 13.03.2023.
//

import Foundation

final class ReviewsStorage {
    static var shared = ReviewsStorage()
    
    private init () {
    }
    
    func getReviewsBy(productId: Int) -> [Review] {
        return [
            Review(
                id_review: 1,
                id_user: 1,
                id_product: 1,
                text: "Хороший продукт"
            ),
            Review(
                id_review: 2,
                id_user: 2,
                id_product: 1,
                text: "Плохой продукт"
            ),
        ]
    }

    func addReviewFor(product productId: Int, by userId: Int, text: String) -> Int {
        return 3
    }

    func deleteReview(review: Int, byUser: Int) -> Bool {
        return true
    }

}
