import Combine
import UIKit

//---

struct BackendMock: SomeBackend
{
    func getFeedItems() -> AnyPublisher<[FeedItem], Error>
    {
        return Just("videos")
            .compactMap(NSDataAsset.init(name:))
            .map(\.data)
            .tryMap { try JSONDecoder().decode([FeedItem].self, from: $0) }
            .eraseToAnyPublisher()
    }
    
    func getUser(with _: EntityIdentifier) -> AnyPublisher<User, Error>
    {
        return Just("user")
            .compactMap(NSDataAsset.init(name:))
            .map(\.data)
            .tryMap { try JSONDecoder().decode(User.self, from: $0) }
            .eraseToAnyPublisher()
    }
}
