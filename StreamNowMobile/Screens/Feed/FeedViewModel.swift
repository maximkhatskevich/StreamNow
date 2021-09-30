import SwiftUI

//---

extension FeedItem: Identifiable {}

//---

final
class FeedViewModel: ObservableObject
{
    @Published
    var items: [FeedItem] = []
}
