import Foundation
import Combine
import XCEUniFlow
import XCEPipeline

//---

enum Feed: Feature
{
    struct Pending: StateAuto
    {
        typealias Parent = Feed
    }
    
    struct Loading: State
    {
        typealias Parent = Feed
        
        let subscription: AnyCancellable
    }
    
    struct Ready: State
    {
        typealias Parent = Feed
        
        let items: [Item]
    }
    
    struct Failed: State
    {
        typealias Parent = Feed
        
        let error: Error
    }
}

// MARK: - Nested types

extension Feed
{
    struct Item
    {
        let id: EntityIdentifier = UUID().uuidString // will be usefull later for SwiftUI
        let videoDescription: String
        let videoURL: URL
        let videoNumber_likes: UInt
        let videoNumber_comments: UInt
        let userId: EntityIdentifier
        let userName: String
        let userImagePath: String // could be URL!
        
        init(from backendFeedItem: FeedItem)
        {
            self.videoDescription = backendFeedItem.video_description
            self.videoURL = backendFeedItem.video_path
            self.videoNumber_likes = backendFeedItem.video_number_likes
            self.videoNumber_comments = backendFeedItem.video_number_comments
            self.userId = backendFeedItem.user_id
            self.userName = backendFeedItem.user_name
            self.userImagePath = backendFeedItem.user_image_path
        }
    }
}

// MARK: - Bindings

extension Feed: NoBindings {}

// MARK: - Actions

extension Feed
{
    static
    func prepare() -> Action
    {
        return Initialization.Into<Pending>.automatically()
    }
    
    static
    func loadData() -> Action
    {
        return Transition.Between<Pending, Loading>.via
        {
            context, _, become, submit in
            
            //---
            
            let subscription = try context
                .state(ofType: BackendProvider.Ready.self)
                .backend
                .getFeedItems()
                .flatMap(
                    \.publisher
                )
                .map(
                    Item.init(from:)
                )
                .collect()
                .sink(
                    receiveCompletion: {

                        if
                            case .failure(let error) = $0
                        {
                            error ./ loadingFailed(_:) ./ submit
                        }
                    },
                    receiveValue: {

                        $0 ./ loadingSucceeded(_:) ./ submit
                    })
            
            //---
            
            subscription
                ./ Loading.init(subscription:)
                ./ become
        }
    }
    
    static
    func loadingSucceeded(_ items: [Item]) -> Action
    {
        return Transition.Between<Loading, Ready>.via
        {
            _, become, _ in
            
            //---
            
            items
                ./ Ready.init(items:)
                ./ become
        }
    }
    
    static
    func loadingFailed(_ error: Error) -> Action
    {
        return Transition.Between<Loading, Failed>.via
        {
            _, become, _ in
            
            //---
            
            error
                ./ Failed.init(error:)
                ./ become
        }
    }
}
