import SwiftUI
import XCEUniFlow

//---

extension Feed.Item: Identifiable {}

//---

final
class FeedViewModel: ObservableObject, StateObserver
{
    @Published
    var items: [Feed.Item] = []
}

// MARK: - Bindings

extension FeedViewModel
{
    static
    let bindings: [ObserverBinding] = [
    
        scenario()
            .when("Data is ready",
                  Transition.Into<Feed.Ready>.done)
            .givn("Take the items",
                  mapMutation: { $0.newState.items })
            .then("Propagate it to the view",
                  do: { $0.items = $1 })
    ]
}
