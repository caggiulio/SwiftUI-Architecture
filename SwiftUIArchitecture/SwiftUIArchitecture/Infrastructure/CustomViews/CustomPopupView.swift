//
//  CustomPopupView.swift
//

import SwiftUI

/// A custom popup view to present with `customPopupView` modifier.
struct CustomPopupView<Content, PopupView>: View where Content: View, PopupView: View {
  
  // MARK: - Stored Properties
  
  /// Wheter the popup is presented or not.
  @Binding var isPresented: Bool
  
  /// The content of the view.
  @ViewBuilder let content: () -> Content
  
  /// The popup view.
  @ViewBuilder let popupView: () -> PopupView
  
  /// The background color.
  let backgroundColor: Color
  
  /// The optional animation.
  let animation: Animation?
  
  var body: some View {
    content()
      .animation(nil, value: isPresented)
      .overlay(isPresented ? backgroundColor.ignoresSafeArea() : nil)
      .overlay(isPresented ? popupView() : nil)
      .animation(animation, value: isPresented)
  }
}

extension View {
  /// The modifier to present the generic `PopupView`.
  /// - Parameters:
  ///   - isPresented: Wheter the popup is presented or not.
  ///   - popupView: The popup view.
  ///   - backgroundColor: The background color.
  ///   - animation: The optional animation.
  /// - Returns: The generic `PopupView`.
  func customPopupView<PopupView>(
    isPresented: Binding<Bool>,
    popupView: @escaping () -> PopupView,
    backgroundColor: Color = .black.opacity(0.7),
    animation: Animation? = .default
  ) -> some View where PopupView: View {
    return CustomPopupView(isPresented: isPresented, content: { self }, popupView: popupView, backgroundColor: backgroundColor, animation: animation)
  }
}
