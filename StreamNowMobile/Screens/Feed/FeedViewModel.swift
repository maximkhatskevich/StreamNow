import Combine
import SwiftUI

//---

extension FeedItem: Identifiable {}

//---

final
class FeedViewModel: ObservableObject
{
    @EnvironmentObject var backendProvider: BackendProvider
    
    @Published
    var items: [FeedItem] = []
    
    var subscription: AnyCancellable?
    
    //---
    
    init()
    {
        self.subscription = backendProvider
            .backend
            .getFeedItems()
            .sink(
                receiveCompletion: { [weak self] _ in
                    
                    self?.subscription = nil
                },
                receiveValue: { [weak self] in
                    
                    self?.items = $0
                })
    }
}
