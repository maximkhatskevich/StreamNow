import SwiftUI

//---

struct ProfileView: View
{
    var body: some View
    {
        NavigationView
        {
            Text("Profile")
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("User Test")
        }
        .tabItem {
            Image(systemName: "person")
        }
    }
}

//---

struct ProfileView_Previews: PreviewProvider
{
    static
    var previews: some View
    {
        ProfileView()
    }
}
