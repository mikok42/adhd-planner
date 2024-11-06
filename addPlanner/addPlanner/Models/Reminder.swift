//
//  Reminder.swift
//  addPlanner
//
//  Created by Linczewski, Mikolaj on 04/11/2024.
//

import Foundation
import SwiftData

@Model
final class Reminder {
    var text: String
    var type: ReminderType
    var id: UUID?
    
    init(type: ReminderType, text: String) {
        self.text = text
        self.type = type
        self.id = UUID()
    }
}
