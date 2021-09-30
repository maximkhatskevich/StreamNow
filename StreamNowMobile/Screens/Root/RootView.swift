import SwiftUI

//---

struct RootView: View
{
    var body: some View
    {
        TabView
        {
            FeedView()
            ProfileView()
        }
    }
}

//---

struct RootView_Previews: PreviewProvider
{
    static
    var previews: some View
    {
        RootView()
            .environmentObject(StateStorage())
    }
}
