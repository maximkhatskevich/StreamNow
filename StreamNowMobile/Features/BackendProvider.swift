import XCEUniFlow
import XCEPipeline

//---

enum BackendProvider: Feature
{
    struct Ready: State
    {
        typealias Parent = BackendProvider
        
        let backend: SomeBackend
    }
}

// MARK: - Bindings

extension BackendProvider: NoBindings {}

// MARK: - Actions

extension BackendProvider
{
    static
    func prepare(with backend: SomeBackend) -> Action
    {
        return Initialization.Into<Ready>.via
        {
            become, _ in
            
            //---
            
            backend
                ./ Ready.init(backend:)
                ./ become
        }
    }
}
