//
//  Splash+ViewModel.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Foundation

extension UI.Funnel.Splash {
  class ViewModel: MystiqueViewModel<EmptyModel> {
    
    // MARK: - DidAppear
    
    override func didAppear() async throws {
      try await processAndForget {
        try await UseCase.GetPokemonByIdentifier().execute()
        coordinator.home()
      }
    }
  }
}
