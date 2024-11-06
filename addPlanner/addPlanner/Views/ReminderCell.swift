//
//  ReminderCell.swift
//  addPlanner
//
//  Created by Linczewski, Mikolaj on 04/11/2024.
//
import SwiftUI

struct ReminderCell: View {
    @State var reminder: Reminder
    
    var body: some View {
        HStack {
            Text(reminder.text ?? "empty")
                .foregroundStyle(.primary)
            Spacer()
            Text(getEmoji(type: reminder.type ?? .shortTerm))
                .frame(width: 50)
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
    }
    
    func getEmoji(type: ReminderType) -> String {
        switch type {
        case .shortTerm:
            return "🚨"
        case .longTerm:
            return "🕰️"
        }
    }
}

