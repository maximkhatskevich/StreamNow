struct User: Decodable
{
    let user_name: String
    let user_title: String
    let user_local_image: String
    let user_videos: UInt
    let user_following: UInt
    let user_fans: UInt
    let user_hearts: UInt
}
