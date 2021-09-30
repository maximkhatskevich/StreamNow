import Combine
import Foundation

//---

/// Abstract representation of a service that acts as backend for this particular app,
/// expected to be URL/HTTP request based web service (endpoints based).
protocol SomeBackend
{
    func getFeedItems() -> AnyPublisher<[FeedItem], Error>
    func getUser(with id: EntityIdentifier) -> AnyPublisher<User, Error>
}
