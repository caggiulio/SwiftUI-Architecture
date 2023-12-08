//
//  PokemonUseCase.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Foundation
import VenomInjector

extension UseCase {
  /// Get a Pokemon by his identifier.
  struct GetPokemonByIdentifier {
    /// The Pokemon repository.
    @Injected private var pokemonRepository: Repository.Pokemon
    
    func execute() async throws {
      let identifier = Int.random(in: 1...150).formatted()
      try await pokemonRepository.getPokemon(identifier: identifier)
    }
  }
}
