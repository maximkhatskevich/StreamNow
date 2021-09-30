import SwiftUI
import XCEUniFlow
import XCEPipeline

//---

@main
struct StreamNowMobile: App
{
    let stateStorage = StateStorage()
    
    //---
    
    var body: some Scene
    {
        WindowGroup
        {
            RootView()
                .environmentObject(stateStorage)
        }
    }
}
