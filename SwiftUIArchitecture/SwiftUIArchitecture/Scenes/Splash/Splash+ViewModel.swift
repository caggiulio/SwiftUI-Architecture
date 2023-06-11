//
//  Splash+ViewModel.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Foundation

extension UI.Funnel.Splash {
  class ViewModel: MystiqueViewModel<SplashModel> {
    
    // MARK: - DidAppear
    
    override func didAppear() async throws {
      localState = .success(
        SplashModel(
          imageName: "logo",
          imageSize: CGSize(width: 300, height: 300)
        )
      )
      
      try await processAndForget {
        try await UseCase.GetPokemonByIdentifier().execute()
        coordinator.home()
      }
    }
  }
}
