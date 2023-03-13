import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: TodoController())

    let controller = AuthController()
    app.post("register", use: controller.register)

    let reviewController = ReviewController()
    app.post("reviews", use: reviewController.reviewListForProduct)
    app.post("reviewAdd", use: reviewController.reviewAddForProduct)
    app.post("reviewDelete", use: reviewController.reviewDelete)
}
