import SwiftUI

//---

struct FeedItem: Identifiable, Decodable
{
    var id: EntityIdentifier = UUID().uuidString
    
    let video_description: String
    let video_path: URL
    let video_number_likes: UInt
    let video_number_comments: UInt
    let user_id: EntityIdentifier
    let user_name: String
    let user_image_path: String // could se URL!
}

//---

final
class FeedViewModel: ObservableObject
{
    @Published
    var items: [FeedItem] = []
}
