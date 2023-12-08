//
//  ErrorManager.swift
//

import Foundation

struct ErrorManager {
  /// Decode the error from the network and return it.
  static func parseCustomError(data: Data, response: URLResponse) -> CustomError {
    ErrorManager.decodeCustomError(data: data, response: response)
  }

  /// Try to decode the error from the `HTTPURLResponse` and return the right error.
  private static func decodeCustomError(data: Data, response: URLResponse) -> CustomError {
    /*let decoder = JSONDecoder()
    if let errorResponse = try? decoder.decode(Model.Data.Error.self, from: data) {
      return handleCustomCustomError(error: errorResponse)
    }*/
    
    return handleCustomError(response: response)
  }
  
  /*/// Returns the `CustomError` based on their custom code.
  private static func handleCustomError(error: Model.Data.Error) -> CustomError {
    switch error.statusCode {
    case 404:
      return CustomError.resourceNotFound
      
    default:
      return CustomError.genericError(error.message)
    }
  }*/
  
  /// Returns the `CustomError` based on their custom code.
  private static func handleCustomError(response: URLResponse) -> CustomError {
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
