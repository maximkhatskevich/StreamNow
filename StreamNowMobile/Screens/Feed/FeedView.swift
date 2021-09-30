import Foundation
import SwiftUI
import AVKit
import XCEPipeline

//---

struct FeedView: View
{
    @StateObject
    var viewModel = FeedViewModel()
    
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
                    
                    item.video_path
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
    }
}

struct FeedView_Previews: PreviewProvider
{
    static
    var previews: some View
    {
        FeedView()
    }
}
