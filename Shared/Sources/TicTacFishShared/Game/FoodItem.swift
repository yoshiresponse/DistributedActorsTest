//
//  FoodItem.swift
//  
//
//  Created by Yoshi Martodihardjo on 17/06/2022.
//

import Foundation

/// Food Item
public struct FoodItem : Codable, Sendable, Identifiable, Hashable {
    
    /// ID
    public let id = UUID()
    
    /// Name
    public var name : String
    
    /// Price
    public var price : Double
    
    /// Count
    public var count: Int = 0
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}
