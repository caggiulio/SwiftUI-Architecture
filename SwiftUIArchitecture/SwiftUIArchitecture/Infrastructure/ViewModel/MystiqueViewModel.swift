//
//  MystiqueViewModel.swift
//
//

import Combine
import SwiftUI

open class MystiqueViewModel<Model: CustomModel>: ObservableObject {
  // MARK: - Computed Properties
  
  /// The loading state with his related `Model`.
  @Published var localState: LocalState<Model, CustomError> = .idle
  
  /// The last value of the `Model` if exist. This variable is assigned when a `LocalState`
  /// become `.success`.
  @Published var model: Model?
  
  /// Wheter the view has the default background. `true` by default.
  @Published var hasDefaultBackground: Bool = true
  
  /// The assembler of the app.
  @Injected var assembler: Assembler
  
  /// The coordinator of the app.
  @ObservedObject var coordinator: Coordinator = Resolver.shared.resolve()
  
  /// The app state.
  @Injected var appState: StateContainer
    
  /// The cancellables set used for store `Combine` values.
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - Init
  
  /// Initializes the view model with default values and sets up subscriptions to the local state and app state.
  init() {
    self.$localState
      .sink { [weak self] state in
        guard let newValue = state.value else {
          return
        }
        self?.model = newValue
      }
      .store(in: &cancellables)
    
    self.appState.$state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.update(state: state)
        
        // TODO: Implements the changes
        
        /// In order to send a signal everytime the state changes.
        //self?.objectWillChange.send()
      }
      .store(in: &cancellables)
  }
  
  // MARK: - Methods
    
  /**
  Processes an asynchronous operation and returns a model.

  This function takes an asynchronous operation that returns a generic model and processes it, potentially displaying a loading indicator if the `withLoader` parameter is set to `true`. If the operation completes successfully, the model is returned, otherwise an error is thrown.

  - Parameters:
      - function: The asynchronous operation that returns the model.
      - withLoader: If `true`, a loading indicator is displayed while the operation is being processed. Defaults to `true`.

  - Throws: An error that occurred during the operation.

  - Returns: The model that was returned by the asynchronous operation.

  Usage:
  You can call this function to process an asynchronous operation that returns a model.

  Example:
  Here's an example of how you might use the `process` function to fetch data from a remote server and display it in a SwiftUI view:
  ```
   func fetch() {
     async {
       try await processAndForget(fetchData)
     }
   }

   func fetchData() async throws -> DataModel {
     // Fetch data from a remote server.
   }
  ```
  Subclassing:
   This function can be overridden in subclasses to provide custom behavior. The default implementation of this function simply processes the operation and returns the result.
   */
  @MainActor
  func process(_ function: () async throws -> Model, _ withLoader: Bool = true) async rethrows {
    withLoader ? localState = .loading : nil
    
    do {
      let successModel = try await function()
      self.localState = .success(successModel)
    } catch let error {
      guard let error = error as? CustomError else {
        self.localState = .failure(CustomError.genericError(error.localizedDescription))
        return
      }
      self.localState = .failure(error)
    }
  }
  
  /**
   Processes an asynchronous function and forgets its result.

   - Parameter function: The asynchronous function to be processed.
   - Parameter withLoader: Whether to display a loader while the function is being executed. Defaults to `true`.
   - Throws: This function rethrows any errors thrown by the `function` parameter.

   This function takes an asynchronous function as a parameter and processes it, ignoring its result. If the function throws an error, the `localState` property of the caller will be set to `.failure(error)`.

   By default, this function displays a loader while the function is being executed, but you can disable this behavior by passing `false` as the second parameter.

   You can call this function whenever you need to process an asynchronous function and don't care about its result, typically in response to a user action or an event in the app.

   Example usage:
   ```
      func fetch() {
        async {
          try await processAndForget(fetchData)
        }
      }

      func fetchData() async throws {
        // Fetch data from a remote server.
      }
   ```
   - Note: This function should not be overridden in subclasses, as it is not meant to be customized. However, you can call this function from other functions or methods in your app as needed.
  */
  @MainActor
  func processAndForget(_ function: () async throws -> Void, _ withLoader: Bool = true) async rethrows {
    withLoader ? localState = .loading : nil
    
    do {
      try await function()
      localState = .idle
    } catch let error {
      guard let error = error as? CustomError else {
        self.localState = .failure(CustomError.genericError(error.localizedDescription))
        return
      }
      self.localState = .failure(error)
    }
  }
  
   /**
    Executes custom logic when a SwiftUI view appears.

    This function is called when a SwiftUI view appears on screen, and it is marked with the `async` and `throws` keywords to indicate that it can perform asynchronous and potentially error-prone operations. The function should execute any custom logic that is required when the view appears, which may include fetching data, performing animations, or updating the UI.

    This function should be overridden in subclasses to provide custom behavior for specific views.

    - Throws: This function may throw an error if an error occurs during its execution. Subclasses should document the types of errors that this function may throw, and callers should be prepared to handle these errors.

    Usage:
    You can call this function whenever you need to perform custom logic when a SwiftUI view appears, typically in the body of the view that is being displayed.

    Example:
    Here's an example of how you might use the didAppear function to fetch data from a remote server when a specific SwiftUI view appears:
    ```
      struct MyView: View {
        var body: some View {
          Text("Hello, World!")
            .onAppear {
               do {
                 try await didAppear()
               } catch {
                 // Handle the error.
               }
            }
          }
        }
   ```
    - Note: that this is just an example, and the actual usage of the `didAppear` function may vary depending on the specific requirements of your app.

  Subclassing:
  Subclasses should override this function to provide custom behavior for specific views. The default implementation of this function does nothing.
  */
  @MainActor
  func didAppear() async throws {}
  
  /**
  Cancels all the cancellables stored in the array.

  This function cancels all the cancellable objects that have been added to the cancellables array. It uses the cancel() function of each Cancellable element in the array to stop any ongoing operations or subscriptions.
   
  Usage:
  ```
   viewModel.unsubscribe()
  ```
  - Note: This function does not remove the cancelled elements from the cancellables array.
   
   The unsubscribe() function is a method that cancels all the cancellable objects in the cancellables array. It iterates through each element in the array and calls its cancel() function to stop any ongoing operations or subscriptions.

   It is important to note that this function does not remove the cancelled elements from the cancellables array. If you want to remove the cancelled objects from the array, you will need to do so manually.

   You can call this function on an instance of an object that has an array of cancellable objects, like so: myObject.unsubscribe().
  */
  func unsubscribe() {
    cancellables.forEach { element in
      element.cancel()
    }
  }
  
  /**
  Handles an error in the app.

  This function is called whenever an error occurs in the app, and it takes a single argument, error, that represents the error that occurred. The function should handle the error in an appropriate way, which may include logging the error, displaying an error message to the user, or taking other actions to recover from the error.

  This function should be overridden in subclasses to customize the error handling behavior for specific view models.

  Parameters:
  - error: An instance of the HBError enum that represents the error that occurred.

  Usage:
  You can call this function whenever you need to handle an error in the app, typically in response to an error event that occurs in the app.

  Example:
  Here's an example of how you might use the handleError function to handle a network error that occurred in a specific view model:

      override func handleError(error: HBError) {
        print(error.localizedDescription)
      }

  Note that this is just an example, and the actual usage of the handleError function may vary depending on the specific requirements of your app.

  Subclassing:
  Subclasses should override this function to provide custom error handling behavior for specific view models. The default implementation of this function does nothing.
  */
  @MainActor
  open func handleError(error: CustomError) {}

   /**
   Updates the app state based on the provided input state.

   This function is called whenever the app state changes, and it takes a single argument, state, that represents the new state of the app. The function should update the app's internal state based on the input state, which may include changes to data, user interface, or other app components.

   This function should be overridden in subclasses to customize the behavior of the app when the state changes.

   - Parameters:
     - state: An instance of the AppState struct that represents the new state of the app.

   - Throws:
     This function may throw an error if an error occurs during its execution. Subclasses should document the types of errors that this function may throw, and callers should be prepared to handle these errors.

   - Usage:
     You can call this function whenever you need to update the app state, typically in response to user input or other events that affect the app's behavior.

   - Example:
     Here's an example of how you might use the update function to update the app's internal state based on a change in the user's selection of a color:

         let newState = AppState(selectedColor: .red)
         update(state: newState)

     Note that this is just an example, and the actual usage of the update function may vary depending on the specific requirements of your app.

   - Subclassing:
     Subclasses should override this function to provide custom behavior when the app state changes. The default implementation of this function does nothing.
   */
  open func update(state: AppState) {}
}

