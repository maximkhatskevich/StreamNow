import XCEUniFlow
import XCEPipeline

//---

/// Special feature-container that manages authentication and
/// keeping track of currently logged-in user.
enum Auth: Feature
{
    struct Authorized: State
    {
        typealias Parent = Auth
        
        let userId: EntityIdentifier
    }
    
    /// Logging in, waiting for the auth server to confirm credentials.
    struct AuthorizationRequested: StateAuto
    {
        typealias Parent = Auth
    }
    
    struct Unauthorized: StateAuto
    {
        typealias Parent = Auth
    }
}

// MARK: - Bindings

extension Auth: NoBindings {}

// MARK: - Actions

extension Auth
{
    static
    func prepare() -> Action
    {
        return Initialization.Into<Unauthorized>.automatically()
    }
}
    
// MARK: - Actions - Mock support

extension Auth
{
    static
    func forceAuthorization(with userId: EntityIdentifier) -> Action
    {
        return Initialization.Into<Authorized>.via
        {
            become, submit in
            
            //---
            
            userId
                ./ Authorized.init(userId:)
                ./ become
        }
    }
}
