import XCEUniFlow
import XCEPipeline
import SwiftUI

//---

enum Logger: Feature
{
    struct Running: StateAuto
    {
        typealias Parent = Logger
    }
}

// MARK: - Bindings

extension Logger
{
    static
    let bindings: [ModelBinding] = [
    
        scenario()
            .when("Any mutation happens",
                  AnyMutation.done)
            .givn("Get current state of the feature in question",
                  map: { try $1.relatedToFeature ./ $0.state })
            .then("Log it into Console",
                  do: { print("ℹ️ \($1 ./ String.init(reflecting:))") })
    ]
}

// MARK: - Actions

extension Logger
{
    static
    func run() -> Action
    {
        return Initialization.Into<Running>.automatically()
    }
}
