//
//  NetworkManager.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Foundation
import AloyNetworking
 
/// The manager for the networking workers.
struct NetworkManager {
  /// The concrete implementation of `AloyNetworkingProtocol`.
  private let networking: AloyNetworkingProtocol = {
    let networking = AloyNetworking(
      baseURL: "https://pokeapi.co/api/v2/", cachePolicy: .returnCacheDataElseLoad
    )
    return networking
  }()

  /// This is the implementation of `NetworkDataSourceProtocol`
  var worker: NetworkDataSourceProtocol

  init() {
    worker = NetworkWorker(networking: networking)
  }
}
