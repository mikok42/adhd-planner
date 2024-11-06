//
//  ContentView.swift
//  addPlanner
//
//  Created by Linczewski, Mikolaj on 04/11/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Reminder]

    var body: some View {
        NewReminderCell()
            .scenePadding(ScenePadding.minimum, edges: .all)
                List {
                    ForEach(items) { item in
                        ReminderCell(reminder: item)
                            .swipeActions(edge: .trailing) {
                                Button("delete", role: .destructive) {
                                    modelContext.delete(item)
                                }
                            }
                    }
                }
        }
}

#Preview {
    ContentView()
        .modelContainer(for: Reminder.self, inMemory: true)
}
