//
//  ReminderCell.swift
//  addPlanner
//
//  Created by Linczewski, Mikolaj on 04/11/2024.
//
import SwiftUI
import EventKit

struct NewReminderCell: View {
    @State private var text: String = ""
    @State private var selectedType: ReminderType = .shortTerm
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        HStack {
            VStack {
                Button(action: {
                    selectedType = .shortTerm
                }) {
                    Text(ReminderType.shortTerm.rawValue)
                        .foregroundStyle(.black)
                }
                    .frame(width: 50, height: 50)
                    .background(Color(decideColor(buttonFor: .shortTerm)))
                    .buttonStyle(.plain)
                    .clipShape(.buttonBorder)
                
                Button(action: {
                    selectedType = .longTerm
                }) {
                    Text(ReminderType.longTerm.rawValue)
                        .foregroundStyle(.black)
                }
                    .frame(width: 50, height: 50)
                    .background(Color(decideColor(buttonFor: .longTerm)))
                    .buttonStyle(.plain)
                    .clipShape(.buttonBorder)
        
            }
            
            TextField("What do you need to do?", text: $text)
                .onSubmit { addReminder() }
        }
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .clipShape(.buttonBorder)
    }
    
    func decideColor(buttonFor: ReminderType) -> UIColor {
        if selectedType == buttonFor {
            return .green
        } else {
            return .gray
        }
    }
    
    func addReminder() {
        createSystemReminder()
        saveReminder()
        text = ""
        
    }
    
    func saveReminder() {
        let newItem = Reminder(type: selectedType, text: text)
        modelContext.insert(newItem)
    }
    
    private func getDate() -> Date {
        return switch selectedType {
        case .shortTerm:
            Date().moved(by: 30, .minute)
        case .longTerm:
            Date().moved(by: 4, .hour)
        }
    }
    
    func createSystemReminder() {
        let eventStore = EKEventStore()
        eventStore.requestFullAccessToReminders() { granted, error in
            if let error {
                print(error.localizedDescription)
            } else {
                let reminder = EKReminder(eventStore: eventStore)
                let dueDate = getDate()
                
                reminder.dueDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
                reminder.title = text
                
                let defaultCalendar = eventStore.defaultCalendarForNewReminders()
                
                if let defaultCalendar {
                    reminder.calendar = defaultCalendar
                    reminder.alarms?.append(.init(absoluteDate: dueDate))
                    do {
                        try eventStore.save(reminder, commit: true)
                    } catch {
                        print("chuj dupa kamieni kupa")
                    }
                }
            }
        }
    }
}
