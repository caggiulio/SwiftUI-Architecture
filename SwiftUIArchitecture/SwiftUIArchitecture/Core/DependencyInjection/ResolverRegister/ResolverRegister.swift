//
//  DependencyManager.swift
//

import Foundation

extension Resolver: ResolverRegistering {
  public static func registerAllServices() {
    Resolver.register { Repository.Pokemon() }.scope(.application)
    Resolver.register { StateContainer() }.scope(.application)
    Resolver.register { Coordinator() }.scope(.application)
    Resolver.register { NetworkManager() }.scope(.application)
    Resolver.register { Assembler() }.scope(.application)
  }
}
