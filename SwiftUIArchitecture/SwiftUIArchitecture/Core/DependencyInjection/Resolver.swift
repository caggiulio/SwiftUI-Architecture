//
//  Resolver.swift
//

import Foundation

/// The `Resolver` manage the storage of dependencies.
class Resolver {
  // MARK: - Stored Properties
  
  /// The shared instance of `Resolver`.
  static let shared = Resolver()
  
  // MARK: - Computed Properties
  
  /// The storage dictionary of the app.
  private var storage = [String: Injectable]()
  
  // MARK: - Init
  
  /// The init of the class.
  private init() {}
  
  // MARK: - Methods
  
  /// The func that stores an `Injectable` in the `storage`.
  /// - Parameter injectable: the `Injectable` to add to the `storage`.
  func add<T: Injectable>(_ injectable: T) {
    let key = String(reflecting: T.self)
    storage[key] = injectable
  }

  /// The func that returns the `Injectable`.
  /// - Returns: the `Injectable` to resolve.
  func resolve<T: Injectable>() -> T {
    let key = String(reflecting: T.self)
    return storage[key] as? T ?? T()
  }
}
