//
//  BaseView.swift
//

import SwiftUI

/// The base `View` for the module. It's specialized with a `to HB Model` and a `Content`.
/// The base `View` handle the generic `LocalState`.
struct BaseView<Model: CustomModel, Content>: View where Content: View {
  
  // MARK: - Stored Properties
  
  /// The specialized `HBSwiftUIViewModel`.
  let viewModel: MystiqueViewModel<Model>
  
  /// The content `View`.
  let content: Content
    
  // MARK: - Init
  
  /// The init of the base `View`.
  /// - Parameters:
  ///   - viewModel: The specialized `to HBSwiftUIViewModel`.
  ///   - content: The content `View`.
  init(viewModel: MystiqueViewModel<Model>, @ViewBuilder _ content: () -> Content) {
    self.viewModel = viewModel
    self.content = content()
  }
  
  // MARK: - View
  
  var body: some View {
    SheetHelper(stateContainer: viewModel) {
      content
        .handleLocalState(viewModel: viewModel)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
          Task {
            try await viewModel.didAppear()
          }
        }
    }
  }
}

