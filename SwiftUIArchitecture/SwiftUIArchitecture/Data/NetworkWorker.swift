//
//  NetworkWorker.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Foundation
import AloyNetworking

// MARK: - NetworkWorker

struct NetworkWorker: NetworkDataSourceProtocol {
  
  // MARK: - Protocol properties

  var networking: AloyNetworkingProtocol

  // MARK: - Init
  
  /// The `init` with a `AloyNetworkingProtocol`.
  /// - Parameter networking: The `AloyNetworkingProtocol`.
  init(networking: AloyNetworkingProtocol) {
    self.networking = networking
  }
  
  // MARK: -  methods
  
  /// Get and transform the `PokemonDataSource` fetched from the network in the `Pokemon` return object.
  func getPokemon(id: String) async throws -> Pokemon {
    let response = try await processResponse {
      try await getPokemonDataSource(id: id)
    }
    
    return response.normalizedForApp()
  }
  
  private func getPokemonDataSource(id: String) async throws -> PokemonDataSource {
    let path = "/pokemon/\(id)"
    let request = AloyNetworkingRequest(method: .get, path: (path, nil))
    return try await networking.send(request: request)
  }
}

private extension NetworkWorker {
  /// Transform the `Error` in the `to CustomError`.
  func processResponse<SuccessResponse: Decodable>(function: () async throws -> SuccessResponse) async rethrows -> SuccessResponse {
    do {
      return try await function()
    } catch let error {
      guard case AloyNetworkingError.underlying(response: let response, data: let data) = error, let data, let response else { throw CustomError.genericError(error.localizedDescription) }
      
      throw ErrorManager.parseCustomError(data: data, response: response)
    }
  }
}


