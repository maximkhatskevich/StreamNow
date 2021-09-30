import SwiftUI
import XCEPipeline

//---

struct ProfileView: View
{
    @EnvironmentObject
    var stateStorage: StateStorage
    
    @StateObject
    var viewModel = ProfileViewModel()
    
    //---
    
    var body: some View
    {
        NavigationView
        {
            if
                let details = viewModel.details
            {
                ScrollView
                {
                    Image(details.userLocalImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    Text(details.username)
                        .font(.headline)
                    
                    Text("\(details.userVideos) videos")

                    
                    HStack
                    {
                        VStack
                        {
                            Text(String(details.userFollowing))
                            Text("Following")
                        }
                        .padding()
                        
                        VStack
                        {
                            Text(String(details.userFans))
                            Text("Fans")
                        }
                        .padding()
                        
                        VStack
                        {
                            Text(String(details.userHearts))
                            Text("Hearts")
                        }
                        .padding()
                    }
                    
                    Button { } label: {
                        
                        Text("Edit Profile")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .accentColor(.red)
                    .padding()
                    
                    Text("No bio yet.")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                        .padding()
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(details.userTitle)
            }
            else
            {
                Text("No user details available.")
            }
        }
        .tabItem {
            Image(systemName: "person")
        }
        .onAppear {
            stateStorage.dispatcher.subscribe(viewModel)
            Profile.loadDataForCurrentUser() ./ stateStorage.dispatcher.submit(_:)
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
            .environmentObject(StateStorage())
    }
}
