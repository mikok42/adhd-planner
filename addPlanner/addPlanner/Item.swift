//
//  Item.swift
//  addPlanner
//
//  Created by Linczewski, Mikolaj on 04/11/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
