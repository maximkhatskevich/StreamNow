import Foundation
import SwiftUI
import AVKit

//---

struct FeedView: View
{
    var body: some View
    {
        NavigationView
        {
            List
            {
                VideoPlayer(player: .init(url: .init(string: "https://stream.livestreamfails.com/video/5c6b85984b99b.mp4")!))
                    .scaledToFit()
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
