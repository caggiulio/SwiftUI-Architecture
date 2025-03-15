//
//  NetworkWorker.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Foundation
import AloyNetworking
import RealHTTP

// MARK: - NetworkWorker

struct NetworkWorker: NetworkDataSourceProtocol {
  
  // MARK: - Computed Properties
    
  /// The `HTTPClient` object to performs network calls.
  /// The object is contained in `RealHTTP` framework.
  private var client: HTTPClient {
    let stringApiProtocol = "https"
    let stringApiURL = "pokeapi.co/api/v2/"
    guard let baseURL = URL(string: stringApiProtocol + "://" + stringApiURL) else { fatalError("BaseURL not resolved") }
    
    let httpClient = HTTPClient(baseURL: baseURL, configuration: .default)
    httpClient.responseTransformers = [
      LoggerInformation(),
      RetryerSettings()
    ]
    httpClient.validators.append(ErrorTransformer())

    return httpClient
  }
  
  // MARK: - Functions
  
  /// Get and transform the `PokemonDataSource` fetched from the network in the `Pokemon` return object.
  func getPokemon(id: String) async throws -> Pokemon {
    let request = HTTPRequest {
      $0.path = "/pokemon/\(id)"
      $0.method = .get
    }
    
    return try await request.fetch(client).decode(PokemonDataSource.self).normalizedForApp()
  }
}
