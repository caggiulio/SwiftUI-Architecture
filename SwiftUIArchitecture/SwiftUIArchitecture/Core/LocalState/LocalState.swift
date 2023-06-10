//
//  LocalState.swift
//

import Foundation

// MARK: - LocalState

/// This is the `enum` used to defines the state of the `async` method in the `ViewModel` of the app.
public enum LocalState<Value, Error: Swift.Error> {
  case idle
  case loading
  case success(Value)
  case failure(Error)
}

public extension LocalState {
  var value: Value? {
    guard case let .success(value) = self else {
      return nil
    }
    
    return value
  }
  
  var error: Error? {
    guard case let .failure(error) = self else {
      return nil
    }
    
    return error
  }
}
