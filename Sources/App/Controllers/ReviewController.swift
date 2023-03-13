//
//  File.swift
//  
//
//  Created by Aleksandr Derevenskih on 13.03.2023.
//

import Foundation
import Vapor

class ReviewController {
    func reviewListForProduct(_ req: Request) throws -> EventLoopFuture<ReviewsListResponse> {
        guard let body = try? req.content.decode(ReviewListRequest.self) else {
            throw Abort(.badRequest)
        }

        print(body)

        let response = ReviewsListResponse(
            id_product: body.id_product,
            reviews: ReviewsStorage.shared.getReviewsBy(productId: body.id_product)
        )

        return req.eventLoop.future(response)
    }

    func reviewAddForProduct(_ req: Request) throws -> EventLoopFuture<ReviewAddResponse> {
        guard let body = try? req.content.decode(ReviewAddRequest.self) else {
            throw Abort(.badRequest)
        }

        print(body)

        let reviewId = ReviewsStorage.shared.addReviewFor(
            product: body.id_product,
            by: body.id_user,
            text: body.text
        )

        let response = ReviewAddResponse(id_review: reviewId)

        return req.eventLoop.future(response)
    }

    func reviewDelete(_ req: Request) throws -> EventLoopFuture<ReviewDeleteResponse> {
        guard let body = try? req.content.decode(ReviewDeleteRequest.self) else {
            throw Abort(.badRequest)
        }

        print(body)

        let result = ReviewsStorage.shared.deleteReview(review: body.id_review, byUser: body.id_user)
        if result {
            let response = ReviewDeleteResponse(id_review: body.id_review, message: "Review has been removed")
            return req.eventLoop.future(response)
        } else {
            let response = ReviewDeleteResponse(id_review: body.id_review, message: "Error")
            return req.eventLoop.future(response)
        }
    }

}
