//
//  ErrorManager.swift
//

import Foundation

struct ErrorManager {
  /// Decode the error from the network and return it.
  static func parseHBError(data: Data, response: URLResponse) -> CustomError {
    ErrorManager.decodeHBError(data: data, response: response)
  }

  /// Try to decode the error from the `HTTPURLResponse` and return the right error.
  private static func decodeHBError(data: Data, response: URLResponse) -> CustomError {
    let decoder = JSONDecoder()
    /*if let errorResponse = try? decoder.decode(Model.Data.Error.self, from: data) {
      return handleCustomHBError(error: errorResponse)
    }*/
    
    return handleCustomHBError(response: response)
  }
  
  /*/// Returns the `CustomError` based on their custom code.
  private static func handleCustomHBError(error: Model.Data.Error) -> CustomError {
    switch error.statusCode {
    case 404:
      return CustomError.resourceNotFound
      
    default:
      return CustomError.genericError(error.message)
    }
  }*/
  
  /// Returns the `HBError` based on their custom code.
  private static func handleCustomHBError(response: URLResponse) -> CustomError {
    guard let response = response as? HTTPURLResponse else {
      return CustomError.genericError("error")
    }
    
    switch response.statusCode {
    case 404:
      return CustomError.resourceNotFound
      
    default:
      return CustomError.genericError("error")
    }
  }
}
