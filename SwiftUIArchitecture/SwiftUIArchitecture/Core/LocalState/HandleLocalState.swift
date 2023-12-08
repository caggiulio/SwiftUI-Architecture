//
//  HandleLocalState.swift
//

import SwiftUI

/**
 The `HandleLocalState` view modifier is used to handle the `LocalState` of a `View`. It is a `ViewModifier` that takes a generic `Model` type conforming to `CustomModel`, and a viewModel instance of `MystiqueViewModel` with the same `Model` type. This modifier manages the loading state of the view, shows alerts for errors, and updates the toast model based on the `LocalState` of the `viewModel`.
 
 The Model type is the generic `CustomModel` that a `View` can handle.
 */
struct HandleLocalState<Model: CustomModel>: ViewModifier {
  
  // MARK: - Stored Properties
  
  let viewModel: MystiqueViewModel<Model>
  
  // MARK: - Computed Properties
  
  /// The `@State` `Bool` used to show the loader `View`.
  @State private var isLoading: Bool = false
  
  // MARK: - Body
  
  func body(content: Content) -> some View {
    content
      .customPopupView(isPresented: $isLoading, popupView: {
        ZStack {
          Color.black.opacity(0.5)
          
          VStack {
            ProgressView()
            
            Text("Loading")
          }
        }
      })
      .onReceive(viewModel.$localState) { output in
        switch output {
        case .loading:
          isLoading = true
          
        case .failure(let error):
          switch error {
          case .genericError(_), .resourceNotFound:
            isLoading = false
            
          default:
            viewModel.handleError(error: error)
          }
          
        case .success(_):
          isLoading = false
          
        case .idle:
          isLoading = false
        }
      }
  }
}

extension View {
  func handleLocalState<Model: CustomModel>(
    viewModel: MystiqueViewModel<Model>
  ) -> some View {
    modifier(HandleLocalState(viewModel: viewModel))
  }
}
