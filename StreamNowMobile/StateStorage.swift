import SwiftUI
import XCEUniFlow

//---

final
class StateStorage: ObservableObject
{
    let dispatcher = Dispatcher(defaultReporting: .short).proxy
}

