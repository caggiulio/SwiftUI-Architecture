//
//  State.swift
//

import Foundation

/// The App state in which every current session information is stored. Is used only to store data.
public struct AppState: Injectable {
  /// The `PokemonDetail` state.
  var pokemonDetail = PokemonDetail()
}
