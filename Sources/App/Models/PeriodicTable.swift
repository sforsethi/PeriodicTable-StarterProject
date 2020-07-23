import Vapor
import FluentPostgreSQL

final class PeriodicTable: Codable {
  var id: Int?
  var symbol: String
  var name: String

  init(symbol: String, name: String) {
    self.symbol = symbol
    self.name = name
  }
}

extension PeriodicTable: PostgreSQLModel {
  typealias Database = PostgreSQLDatabase
}

extension PeriodicTable: Migration {}

extension PeriodicTable: Content {}
