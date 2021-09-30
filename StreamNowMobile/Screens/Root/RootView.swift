import SwiftUI

//---

struct RootView: View
{
    let backendProvider = BackendProvider(backend: BackendMock())
    
    var body: some View
    {
        TabView
        {
            FeedView()
            ProfileView()
        }
        .environmentObject(backendProvider)
    }
}

struct RootView_Previews: PreviewProvider
{
    static
    var previews: some View
    {
        RootView()
    }
}
