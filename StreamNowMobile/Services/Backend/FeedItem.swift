import Foundation

//---

/// Representation of a single feed item that we expect to receive from backend.
struct FeedItem: Decodable
{
    var id: EntityIdentifier = UUID().uuidString // will be usefull later for SwiftUI
    
    let video_description: String
    let video_path: URL
    let video_number_likes: UInt
    let video_number_comments: UInt
    let user_id: EntityIdentifier
    let user_name: String
    let user_image_path: String // could se URL!
}
