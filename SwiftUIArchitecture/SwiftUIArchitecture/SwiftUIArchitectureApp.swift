//
//  SwiftUIArchitectureApp.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import SwiftUI

@main
struct SwiftUIArchitectureApp: App {
  
  // MARK: - Stored Properties
  
  /// The `DependencyManager` that adds the dependencies in the init.
  private let manager = DependencyManager()
  
  /// The app coordinator.
  @ObservedObject var coordinator: Coordinator = Resolver.shared.resolve()
  
  /// The responsible of the assemble of the `View` used to assemble a view for navigation.
  @Injected var assembler: Assembler
  
  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $coordinator.path) {
        assembler.splash()
          .navigationDestination(for: CoordinatorLink.self) { link in
            assembler.navigateTo(destination: link)
          }
      }
    }
  }
}
