/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Types which are used to model the table state.
*/

/// Represents the state of the table, including all items in the order
public struct TableState: Sendable {
    
    /// Order
    private var order : [FoodItem] = []
    
    /// Add Item
    public mutating func addItem(item: FoodItem) {
        order.append(item)
    }
    
    /// Set Order
    public mutating func setOrder(order: [FoodItem]) {
        self.order = order
    }
    
    /// Get  count of the items in the order
    public func getCount() -> Int {
        return order.count
    }
    
    /// Get Order
    public func getOrder() -> [FoodItem] {
        return order
    }
    
}
