import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(
  _ config: inout Config,
  _ env: inout Environment,
  _ services: inout Services
) throws {
  // 2
  try services.register(FluentPostgreSQLProvider())

  let router = EngineRouter.default()
  try routes(router)
  services.register(router, as: Router.self)

  var middlewares = MiddlewareConfig()
  middlewares.use(ErrorMiddleware.self)
  services.register(middlewares)

  var databases = DatabasesConfig()
  // 3
  let databaseConfig = PostgreSQLDatabaseConfig(
    hostname: "localhost",
    username: "vapor",
    database: "vapor",
    password: "password"
    )
    
    
  let database = PostgreSQLDatabase(config: databaseConfig)
  databases.add(database: database, as: .psql)
  services.register(databases)
  var migrations = MigrationConfig()
  // 4
  migrations.add(model: PeriodicTable.self, database: .psql)
  services.register(migrations)
}

