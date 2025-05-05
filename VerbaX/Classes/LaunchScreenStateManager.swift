//import Foundation
//
//final class LaunchScreenStateManager: ObservableObject {
//
//    @MainActor @Published private(set) var state: LaunchScreenStep = .firstStep
//
//    @MainActor func dismiss() {
//        Task {
//            state = .secondStep
//
//            try? await Task.sleep(for: Duration.seconds(1))
//
//            self.state = .finished
//        }
//    }
//}

import Foundation

final class LaunchScreenStateManager: ObservableObject {
    @Published var state: LaunchScreenStep = .firstStep

    func dismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.state = .secondStep
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.state = .finished
            }
        }
    }
}
