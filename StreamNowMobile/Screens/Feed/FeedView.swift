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
                    
                    item.videoURL
                        ./ AVPlayer.init(url:)
                        ./ VideoPlayer.init(player:)
                        ./ { $0.scaledToFit() }
                }
            }
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
    static
    var previews: some View
    {
        FeedView()
    }
}
