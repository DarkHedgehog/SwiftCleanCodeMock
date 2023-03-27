//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 13.03.2023.
//

import Foundation
import Vapor

class ReviewController {
    
    func reviewListForProduct(_ req: Request) async throws -> ReviewsListResponse {
        guard let body = try? req.content.decode(ReviewListRequest.self) else {
            throw Abort(.badRequest)
        }

        let shopDb = ShopDatabase.shared

        guard
            let product = try await shopDb.productById(body.productId, db: req.db),
            let reviews = try await shopDb.reviewsByProductId(body.productId, db: req.db) else {
            return ReviewsListResponse(result: -1, error_message: "Product not found")
        }

        var result: [ReviewDetail] = []


        for review in reviews {
            if let reviewId = review.id,
               let user = try await shopDb.userById(review.userId, db: req.db) {
                result.append(
                    ReviewDetail(
                        id: reviewId,
                        product: product,
                        user: user,
                        stars: review.stars,
                        text: review.text))
            }
        }

        let response = ReviewsListResponse(
            result: 1,
            error_message: nil,
            productId: body.productId,
            reviews: result
        )

        return response
    }

    func reviewAddForProduct(_ req: Request) async throws -> ReviewAddResponse {
        guard let body = try? req.content.decode(ReviewAddRequest.self) else {
            throw Abort(.badRequest)
        }

        let shopDb = ShopDatabase.shared

        let reviewRecord = Review(
            productId: body.productId,
            userId: body.userId,
            stars: body.stars,
            text: body.text)

        try await reviewRecord.save(on: req.db)

        let response = ReviewAddResponse(
            reviewId: reviewRecord.id,
            result: 1,
            error_message: nil
        )

        return response
    }

    func reviewDelete(_ req: Request) async throws -> ReviewDeleteResponse {
        guard let body = try? req.content.decode(ReviewDeleteRequest.self) else {
            throw Abort(.badRequest)
        }

        let shopDb = ShopDatabase.shared

        // check for user exists
        guard let _ = try await shopDb.userById(body.userId, db: req.db) else {
            return ReviewDeleteResponse(
                result: -1,
                reviewId: body.reviewId,
                error_message: "User not found")
        }

        guard let reviewRecord = try await shopDb.reviewById(body.reviewId, db: req.db) else {
            return ReviewDeleteResponse(
                result: -1,
                reviewId: body.reviewId,
                error_message: "Review not found")
        }

        try await reviewRecord.delete(on: req.db)

        return ReviewDeleteResponse(
            result: 1,
            reviewId: body.reviewId,
            message: "Review removed")
    }
}
