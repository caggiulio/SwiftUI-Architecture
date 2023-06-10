//
//  Created by Nunzio Giulio Caggegi on 17/11/22.
//

import Foundation

/// The protocol to conform it in order to set the `CoordinatorLink`. It's conform to `ObservableObject`.
protocol SheetHelperProtocol: ObservableObject {
  /// The `CoordinatorLink` to set in order to navigate.
  var sheetLink: CoordinatorLink? { get set }
  
  /// The assembler of the app.
  var assembler: Assembler { get set }
  
  /// The coordinator of the app.
  var coordinator: Coordinator { get set }
}
