//
//  CoordinatorLink.swift
//

import Foundation

/// The enums that defines the possible destination links of the flow.
enum CoordinatorLink: Identifiable, Hashable {
  
  /// The splash case.
  case splash
  
  /// The home case.
  case home
  
  // MARK: - Computed Properties
  
  /// The `CoordinatorLink` used in the `ViewModel` for the bottom sheet.
  var sheetItem: CoordinatorLink? {
    switch self {
    default:
      return nil
    }
  }
  
  /// The `CoordinatorLink` used in the `ViewModel` for the full cover content.
  var fullCoverItem: CoordinatorLink? {
    switch self {
    case .splash:
      return .splash
      
    default:
      return nil
    }
  }
  
  /// The `CoordinatorLink` id as `String` . Is the reflecting string of the `View` struct.
  var id: String {
    switch self {
    case .splash:
      return String(reflecting: UI.Funnel.Splash.View.self)
      
    case .home:
      return String(reflecting: UI.Funnel.Home.View.self)
    }
  }
}
