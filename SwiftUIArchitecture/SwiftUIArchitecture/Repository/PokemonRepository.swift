//
//  PokemonRepository.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Foundation
import VenomInjector

extension Repository {
  struct Pokemon: PokemonRepositoryProtocol {
    /// The networking worker.
    @Injected private var networkingManager: NetworkManager
    
    /// The `AppState`.
    @Injected private var stateContainer: StateContainer
    
    /// Get the information of a Pokemon by his identifier.
    func getPokemon(identifier: String) async throws {
      let pokemon = try await networkingManager.worker.getPokemon(id: identifier)
      stateContainer.state.pokemonDetail.selectedPokemon = pokemon
    }
  }
}
