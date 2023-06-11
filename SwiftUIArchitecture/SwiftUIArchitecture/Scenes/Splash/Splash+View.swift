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
      MystiqueView(viewModel: viewModel) {
        ZStack {
          Image("logo")
            .frame(width: 300, height: 300)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
      }
    }
  }
}
