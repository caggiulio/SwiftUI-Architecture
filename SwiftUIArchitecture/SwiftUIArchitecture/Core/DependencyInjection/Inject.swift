//
//  Inject.swift
//

import Foundation

/// The `Injectable` protocol.
protocol Injectable {}

@propertyWrapper
/// The `Inject` property wrapper.
struct Injected<T: Injectable> {
  // MARK: - Stored properties
  
  /// The generic `Injectable`.
  var wrappedValue: T
  
  // MARK: - Init
  
  /// The init of the `Inject` property wrapper.
  init() {
    wrappedValue = Resolver.shared.resolve()
  }
}
