/*
See LICENSE folder for this sample’s licensing information.

Abstract:
ViewModel used by the iOS views and UI-driven distributed actors to interact with eachother.
*/

import SwiftUI

#if canImport(SwiftUI)
@MainActor
public final class TableViewModel: ObservableObject {
    
    /// Staff
    @Published public var staff : [Colleague] = []
    
    /// Table State
    @Published public var tableState: TableState = .init()

    /// Menu
    @Published public var menu: [FoodItem] = [FoodItem(name: "Chicken", price: 10.0), FoodItem(name: "Fries", price: 10.0)]
    
    public init() {
        /// Don't init anything
    }
    
    /// Everytime you add an item, you do it locally then you send your version of the order to everyone, and that is the new version for everyone
    public func addItem(item: FoodItem) async {
        tableState.addItem(item: item)
        Task {
            for colleague in staff {
                try await colleague.setOrder(order: getOrder())
            }
        }        
        return
    }
    
    /// Set Order
    public func setOrder(order: [FoodItem]) {
        tableState.setOrder(order: order)
    }
    
    /// Get Order
    public func getOrder() -> [FoodItem] {
        return tableState.getOrder()
    }
    
    /// Found colleague
    public func foundColleague(_ colleague: Colleague, myself: MySelf, informColleague: Bool) {
        guard !staff.contains(where: { $0.id == colleague.id }) else {
            return
        }
        
        self.staff.append(colleague)
        
        // STEP 2: local multiplayer, enable telling the other colleagues
        
        if informColleague {
            Task {
                try await colleague.joinTable(colleague: myself, startTurn: false)
            }
        }
        
        
            Task {
                if (try await myself.getOrder().isEmpty) {
                try await myself.setOrder(order: colleague.getOrder())

            }
        }
    }
    
    /// Remove Colleagues
    public func removeColleagues(myself: MySelf) {
        staff = [myself]
    }
    
}
#endif
