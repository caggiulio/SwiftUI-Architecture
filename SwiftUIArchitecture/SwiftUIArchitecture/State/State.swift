//
//  State.swift
//

import Foundation

public struct AppState: AppStateable {
  public var pokemonDetail = PokemonDetail()
    
  mutating public func reset() {
    pokemonDetail = PokemonDetail()
  }
}
