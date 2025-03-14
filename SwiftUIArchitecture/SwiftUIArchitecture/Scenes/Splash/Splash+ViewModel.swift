//
//  Splash+ViewModel.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Factory
import Foundation

extension UI.Funnel.Splash {
  class ViewModel: MystiqueViewModel<SplashModel> {
    
    /// The coordinator of the app.
    @Injected(\.coordinator) var coordinator: Coordinator
    
    // MARK: - DidAppear
    
    override func didAppear() async throws {
      localState = .success(
        SplashModel(
          imageName: "logo",
          imageSize: CGSize(width: 300, height: 300)
        )
      )
      
      try await UseCase.GetPokemonByIdentifier().execute()
      self.coordinator.home()
    }
  }
}
