import Foundation
import SwiftUI
import AVKit
import XCEPipeline
import XCEUniFlow

//---

struct FeedView: View
{
    @EnvironmentObject
    var stateStorage: StateStorage
    
    @StateObject
    var viewModel = FeedViewModel()
    
    //---
    
    var body: some View
    {
        NavigationView
        {
            List
            {
                ForEach(viewModel.items)
                {
                    item in
                    
                    //---
                    
                    VStack(alignment: .leading)
                    {
                        item.videoURL
                            ./ AVPlayer.init(url:)
                            ./ VideoPlayer.init(player:)
                            ./ { $0.scaledToFit() }
                        
                        HStack
                        {
                            AsyncImage(
                                url: item.userImageURL,
                                content: { $0 },
                                placeholder: {
                                    
                                    Image("user_photo")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .aspectRatio(contentMode: .fit)
                                }
                            )
                            
                            VStack
                            {
                                Text(item.videoDescription)
                                
                                Text("\(item.userName) | ♡ \(item.videoNumberLikes) | 💬 \(item.videoNumberComments)")
                                    .font(Font.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.top)
                    }
                    .padding(.top)
                    .padding(.bottom)
                }
            }
//            .listStyle(.plain)
            .navigationTitle("Feed")
        }
        .tabItem {
            Image(systemName: "house")
        }
        .onAppear {
            stateStorage.dispatcher.subscribe(viewModel)
            Feed.loadData() ./ stateStorage.dispatcher.submit(_:)
        }
    }
}

//---

struct FeedView_Previews: PreviewProvider
{
    let stateStorage = StateStorage()
    
    //---
    
    static
    var previews: some View
    {
        FeedView()
            .environmentObject(StateStorage())
    }
}
