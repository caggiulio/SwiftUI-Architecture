//
//  Extension+Binding.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import SwiftUI

extension Binding {
  func map<T>(get: @escaping (Value) -> T?, set: @escaping (T?) -> Value) -> Binding<T?> {
    Binding<T?>(
      get: {
        get(wrappedValue)
      },
      set: {
        wrappedValue = set($0)
      }
    )
  }
  
  func map<T>(get: @escaping (Value) -> T, set: @escaping (T) -> Value) -> Binding<T> {
    Binding<T>(
      get: {
        get(wrappedValue)
      },
      set: {
        wrappedValue = set($0)
      }
    )
  }
}
