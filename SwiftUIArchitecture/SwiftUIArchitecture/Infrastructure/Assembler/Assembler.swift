//
//  Assembler.swift
//

import SwiftUI

/// The responsible to assemble and return the `View`s.
struct Assembler: Injectable {
  /// Returns the `Splash` view.
  /*func splash() -> UI.Scene.PreLogin.Splash.View {
    UI.Scene.PreLogin.Splash.View()
  }*/
}

// MARK: - Helpers

extension Assembler {
  /// Solve the navigation basing on `CoordinatorLink`.
  /// - Parameter destination: The `CoordinatorLink`.
  /// - Returns: The related `SwiftUI.View`.
  @ViewBuilder
  func navigateTo(destination: CoordinatorLink) -> some View {
    /*switch destination {
    case .home:
      home()
    }*/
  }
}


