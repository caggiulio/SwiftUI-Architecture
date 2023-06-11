//
//  ArchitectureDependencyManager.swift
//  HomeBridgeApp
//
//  Created by Nunzio Giulio Caggegi on 22/12/22.
//

import Foundation

/// The struct responsible to add the dependencies of the architecture of the app.
struct ArchitectureDependencyManager {
  
  // MARK: - Computed Properties
  
  /// The networking manager instance.
  var networkingManager: NetworkManager {
    NetworkManager()
  }
  
  /// The app coordinator.
  var coordinator: Coordinator {
    Coordinator()
  }

  /// The responsible of the assemble of the `View` used to assemble a view for navigation.
  private var assembler: Assembler {
    Assembler()
  }
  
  /// The App state container.
  var state: StateContainer {
    StateContainer()
  }
  
  /// The Pokemon repository.
  var pokemonRepository: Repository.Pokemon {
    Repository.Pokemon()
  }
    
  // MARK: - Init
  
  /// The init of the manager.
  init() {
    addDependencies()
  }
    
  // MARK: - Private Methods
  
  /// This method add the depencies to shared `Resolver` instance.
  private func addDependencies() {
    let resolver = Resolver.shared
    resolver.add(coordinator)
    resolver.add(networkingManager)
    resolver.add(state)
    resolver.add(assembler)
    resolver.add(pokemonRepository)
  }
}
