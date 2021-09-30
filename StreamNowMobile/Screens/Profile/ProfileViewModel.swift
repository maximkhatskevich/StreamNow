import SwiftUI
import XCEUniFlow

//---

extension Profile.Details: Identifiable {}

//---

final
class ProfileViewModel: ObservableObject, StateObserver
{
    @Published
    var details: Profile.Details?
}

// MARK: - Bindings

extension ProfileViewModel
{
    static
    let bindings: [ObserverBinding] = [
    
        scenario()
            .when("Data is ready",
                  Transition.Into<Profile.Ready>.done)
            .givn("Take the profile details",
                  mapMutation: { $0.newState.details })
            .then("Propagate it to the view",
                  do: { $0.details = $1 })
    ]
}
