import SwiftUI
import XCEUniFlow
import XCEPipeline

//---

final
class StateStorage: ObservableObject
{
    enum InitialConfigurationScenario
    {
        case mockBased
        // case test
        // case prod
    }
    
    //---
    
    let dispatcher = Dispatcher(defaultReporting: .short).proxy
    
    //---
    
    init(with scenario: InitialConfigurationScenario = .mockBased)
    {
        /// configure initial state of the app for given `scenario`
        
        switch scenario
        {
            case .mockBased:
                
                self.dispatcher << [

                    Logger.run(),
                    
                    "123"
                        ./ Auth.forceAuthorization(with:),
                    
                    BackendMock()
                        ./ BackendProvider.prepare(with:),
                    
                    Feed.prepare(),
                    
                    Profile.prepare()
                ]
        }
    }
}

