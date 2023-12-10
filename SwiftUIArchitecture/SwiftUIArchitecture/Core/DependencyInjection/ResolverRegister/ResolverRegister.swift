//
//  DependencyManager.swift
//

import AloyNetworking
import Foundation
import VenomInjector

extension Resolver: ResolverRegistering {
  public static func registerAllServices() {
    Resolver.register { Repository.Pokemon() }.scope(.application).implements(PokemonRepositoryProtocol.self)
    Resolver.register { StateContainer() }.scope(.application)
    Resolver.register { Coordinator() }.scope(.application)
    Resolver.register(NetworkManager.self) {
      let networking: AloyNetworkingProtocol = {
        let networking = AloyNetworking(
          baseURL: "https://pokeapi.co/api/v2/", cachePolicy: .returnCacheDataElseLoad
        )
        return networking
      }()
      
      return NetworkManager(worker: NetworkWorker(networking: networking))
    }
    Resolver.register { Assembler() }.scope(.application)
  }
}
