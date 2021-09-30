import Foundation
import Combine
import XCEUniFlow
import XCEPipeline

//---

enum Profile: Feature
{
    struct Pending: StateAuto
    {
        typealias Parent = Profile
    }
    
    struct Loading: State
    {
        typealias Parent = Profile
        
        let subscription: AnyCancellable
    }
    
    struct Ready: State
    {
        typealias Parent = Profile
        
        let details: Details
    }
    
    struct Failed: State
    {
        typealias Parent = Profile
        
        let error: Error
    }
}

// MARK: - Nested types

extension Profile
{
    struct Details
    {
        let id: EntityIdentifier = UUID().uuidString // will be usefull later for SwiftUI
        let username: String
        let userTitle: String
        let userLocalImage: String
        let userVideos: UInt
        let userFollowing: UInt
        let userFans: UInt
        let userHearts: UInt
        
        init(from user: User)
        {
            self.username = user.user_name
            self.userTitle = user.user_title
            self.userLocalImage = user.user_local_image
            self.userVideos = user.user_videos
            self.userFollowing = user.user_following
            self.userFans = user.user_fans
            self.userHearts = user.user_hearts
        }
    }
}

// MARK: - Bindings

extension Profile: NoBindings {}

// MARK: - Actions

extension Profile
{
    static
    func prepare() -> Action
    {
        return Initialization.Into<Pending>.automatically()
    }
    
    static
    func loadDataForCurrentUser() -> Action
    {
        return Transition.Between<Pending, Loading>.via
        {
            context, _, become, submit in
            
            //---
            
            let userId = try context
                .state(ofType: Auth.Authorized.self)
                .userId
            
            //---
            
            let subscription = try context
                .state(ofType: BackendProvider.Ready.self)
                .backend
                .getUser(with: userId)
                .map(
                    Details.init(from:)
                )
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
    func loadingSucceeded(_ details: Details) -> Action
    {
        return Transition.Between<Loading, Ready>.via
        {
            _, become, _ in
            
            //---
            
            details
                ./ Ready.init(details:)
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
