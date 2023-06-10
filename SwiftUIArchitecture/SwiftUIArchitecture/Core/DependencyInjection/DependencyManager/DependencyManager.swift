//
//  DependencyManager.swift
//

import Foundation

/// The struct to resolve the dependencies of the app.
struct DependencyManager {
  
  // MARK: - Stored Properties
  
  /// The responsible manager to add the depencies of the app architecture.
  private var architectureDepenciesManager: ArchitectureDependencyManager
  
  // MARK: - Init
  
  /// The init of the manager.
  init() {
    architectureDepenciesManager = ArchitectureDependencyManager()
  }
}
