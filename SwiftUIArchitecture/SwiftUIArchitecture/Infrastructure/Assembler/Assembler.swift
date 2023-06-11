//
//  Assembler.swift
//

import SwiftUI

/// The responsible to assemble and return the `View`s.
struct Assembler: Injectable {
  /// Returns the `Splash` view.
  func splash() -> UI.Funnel.Splash.View {
    UI.Funnel.Splash.View()
  }
  
  /// Returns the `Home` view.
  func home() -> UI.Funnel.Home.View {
    UI.Funnel.Home.View()
  }
}

// MARK: - Helpers

extension Assembler {
  /// Solve the navigation basing on `CoordinatorLink`.
  /// - Parameter destination: The `CoordinatorLink`.
  /// - Returns: The related `SwiftUI.View`.
  @ViewBuilder
  func navigateTo(destination: CoordinatorLink) -> some View {
    switch destination {
    case .splash:
      splash()
      
    case .home:
      home()
    }
  }
}


