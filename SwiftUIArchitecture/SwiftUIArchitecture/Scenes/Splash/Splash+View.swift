//
//  Splash+View.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import SwiftUI

extension UI.Funnel.Splash {
  struct View: SwiftUI.View {
    
    // MARK: - Stored Properties
    
    /// The `SplashViewModel` of the view.
    @StateObject var viewModel = UI.Funnel.Splash.ViewModel()
    
    // MARK: - View
    
    var body: some SwiftUI.View {
      MystiqueView(localState: viewModel.localState) { splashModel in
        ZStack {
          Image(splashModel.imageName)
            .frame(width: splashModel.imageSize.width, height: splashModel.imageSize.height)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
      }
      .onAppear {
        Task {
          try await viewModel.didAppear()
        }
      }
      .loader(isShowing: viewModel.localState.isLoading)
    }
  }
}
