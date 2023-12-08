//
//  SwiftUIArchitectureApp.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import VenomInjector
import SwiftUI

@main
struct SwiftUIArchitectureApp: App {
  
  // MARK: - Stored Properties
    
  /// The app coordinator.
  @InjectedObject var coordinator: Coordinator
  
  /// The responsible of the assemble of the `View` used to assemble a view for navigation.
  @Injected var assembler: Assembler
  
  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $coordinator.path) {
        assembler.navigateTo(destination: .splash)
          .navigationDestination(for: CoordinatorLink.self) { link in
            assembler.navigateTo(destination: link)
          }
      }
    }
  }
}
