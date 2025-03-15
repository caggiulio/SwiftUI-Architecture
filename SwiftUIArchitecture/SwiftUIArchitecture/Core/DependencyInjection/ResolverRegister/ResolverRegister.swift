//
//  DependencyManager.swift
//

import AloyNetworking
import Factory
import Foundation

extension Container {
  var pokemonRepository: Factory<PokemonRepositoryProtocol> {
    self { Repository.Pokemon() }
    .scope(.cached)
  }
  
  var stateContainer: Factory<StateContainer> {
    self { StateContainer() }
    .scope(.cached)
  }
  
  var coordinator: Factory<Coordinator> {
    self { Coordinator() }
    .scope(.cached)
  }

  var networkManager: Factory<NetworkManager> {
    self {
      NetworkManager(pokemonWorker: NetworkWorker())
    }
    .scope(.cached)
  }

  var assembler: Factory<Assembler> {
    self { Assembler() }
    .scope(.cached)
  }
}
