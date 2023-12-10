//
//  NetworkManager.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import AloyNetworking
import VenomInjector
 
/// The manager for the networking workers.
struct NetworkManager {
  /// This is the implementation of `NetworkDataSourceProtocol`
  var worker: NetworkDataSourceProtocol
}
