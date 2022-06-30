/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Player actor implementations for the game.
*/

import Distributed
import DistributedActors

public typealias MySelf = LocalStaff
public typealias Colleague = LocalStaff

// ======= ------------------------------------------------------------------------------------------------------------
// - MARK: Staff Protocol
public protocol Staff: DistributedActor, Codable {

}



// ======= ------------------------------------------------------------------------------------------------------------
// - MARK: Local Networking Staff

public distributed actor LocalStaff: Staff {
    public typealias ActorSystem = SampleLocalNetworkActorSystem

    // Model
    let model: TableViewModel

    public init(model: TableViewModel, actorSystem: ActorSystem) {
        self.model = model
        self.actorSystem = actorSystem
    }

    /// Add Item to Table
    public func addItem(item: FoodItem) async  {
        await model.addItem(item: item)
        return
    }

    /// Join Table
    public distributed func joinTable(colleague: Colleague, startTurn: Bool) async {
        await model.foundColleague(colleague, myself: self, informColleague: false)
    }
    
    /// Set Order
    public distributed func setOrder(order: [FoodItem]) async {
        await model.setOrder(order: order)
    }
    
    /// Get Order
    public distributed func getOrder() async -> [FoodItem]{
        return await model.getOrder()
    }
}

