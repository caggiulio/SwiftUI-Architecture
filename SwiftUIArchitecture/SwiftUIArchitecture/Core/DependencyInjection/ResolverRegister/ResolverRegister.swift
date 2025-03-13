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
      let networking: AloyNetworkingProtocol = {
        let networking = AloyNetworking(
          baseURL: "https://pokeapi.co/api/v2/", cachePolicy: .returnCacheDataElseLoad
        )
        
        return networking
      }()
      
      return NetworkManager(worker: NetworkWorker(networking: networking))
    }
    .scope(.cached)
  }

  var assembler: Factory<Assembler> {
    self { Assembler() }
    .scope(.cached)
  }
}
