import SwiftUI
import XCEUniFlow
import XCEPipeline

//---

@main
struct StreamNowMobile: App
{
    let stateStorage = StateStorage()
    
    //---
    
    init()
    {
        // configure initial state of the app:
        stateStorage.dispatcher << [

            Logger.run(),
            
            BackendMock() // TODO: replace with real one before release!
                ./ BackendProvider.prepare(with:),
            
            Feed.prepare()
        ]
    }
    
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
