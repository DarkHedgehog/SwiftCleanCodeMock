import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // postgres://vapor_username:goyqJWWOfVW7jBNbsX1PrGtTakC2jODZ@dpg-cg7vso7dvk4ljrnicaj0-a.oregon-postgres.render.com/vapor_database

//    app.databases.use(.postgres(
//        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
//        username: Environment.get("DATABASE_USERNAME") ?? "postgres",
//        password: Environment.get("DATABASE_PASSWORD") ?? "admin",
//        database: Environment.get("DATABASE_NAME") ?? "postgres"
//    ), as: .psql)

    app.databases.use(.postgres(
        hostname: "dpg-cg7vso7dvk4ljrnicaj0-a.oregon-postgres.render.com",
        port: 5432,
        username: "vapor_username",
        password: "goyqJWWOfVW7jBNbsX1PrGtTakC2jODZ",
        database: "vapor_database",
        tlsConfiguration: .clientDefault
    ), as: .psql)

    app.migrations.add(CreateTodo())
    app.migrations.add(CreateUsers())
    app.migrations.add(CreateProduct())
    app.migrations.add(CreateBasket())

    try app.autoMigrate().wait()
    // register routes
    try routes(app)
}
