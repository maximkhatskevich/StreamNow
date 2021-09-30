import Foundation

//---

/// Representation of a single feed item that we expect to receive from backend.
///
/// NOTE: this ignores naming conventions on this platform and just follows
/// the naming exactly how it is defined in backend response, we can always
/// adjust naming when convert from backend level data objects to feature level.
struct FeedItem: Decodable
{
    var id: EntityIdentifier? = UUID().uuidString // will be usefull later for SwiftUI
    
    let video_description: String
    let video_path: URL
    let video_number_likes: UInt
    let video_number_comments: UInt
    let user_id: EntityIdentifier
    let user_name: String
    let user_image_path: String // could be URL!
}
