//
//  SheetHelper.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 17/11/22.
//

import SwiftUI

/// The `View` used for navigation. It will be contains the `Content`.
struct SheetHelper<StateContainer: SheetHelperProtocol, Content: View>: View {
  
  // MARK: - Stored Properties
  
  /// The `CoordinatorFlowStateProtocol` state of the coordinator.
  @ObservedObject var stateContainer: StateContainer
  
  /// The `Content` struct `View`.
  let content: () -> Content
  
  // MARK: - Computed Properties
  
  /// The special `CoordinatorLink` to show the bottom sheet.
  private var sheetItem: Binding<CoordinatorLink?> {
    $stateContainer.sheetLink.map(get: { $0?.sheetItem }, set: { $0 })
  }
  
  /// The special `CoordinatorLink` to show the bottom sheet.
  private var fullCoverItem: Binding<CoordinatorLink?> {
    $stateContainer.sheetLink.map(get: { $0?.fullCoverItem }, set: { $0 })
  }
  
  // MARK: - Computed Properties {
  
  /// The assembler of the app.
  var assembler: Assembler {
    stateContainer.assembler
  }
  
  // MARK: - Body
  
  var body: some View {
    NavigationView {
      ZStack {
        content()
          .sheet(item: sheetItem, onDismiss: { sheetItem.wrappedValue = nil }, content: sheetContent)
          .fullScreenCover(item: fullCoverItem, onDismiss: { fullCoverItem.wrappedValue = nil }, content: fullCoverContent)
      }
    }
    .navigationViewStyle(.stack)
  }
}

// MARK: - Private Routes Definition

private extension SheetHelper {
  /// The `View` item to pass in the `.sheet` to show a view as a bottom sheet.
  @ViewBuilder
  private func sheetContent(sheetItem: CoordinatorLink) -> some View {
    switch sheetItem {
    /*case .home:
      assembler.home()*/
      
    default:
      content()
    }
  }
  
  /// The `View` item to pass in the `.fullCover` to show a view as a full cover content.
  @ViewBuilder
  private func fullCoverContent(fullCover: CoordinatorLink) -> some View {
    switch fullCover {
    /*case .splash:
      assembler.splash()*/
    
    default:
      content()
    }
  }
}
