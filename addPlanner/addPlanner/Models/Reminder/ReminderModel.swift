//
//  ReminderModel.swift
//  addPlanner
//
//  Created by Linczewski, Mikolaj on 06/11/2024.
//

import SwiftUI
import EventKit
import SwiftData

class ReminderModel {
    @Environment(\.modelContext) private var modelContext
    
    var reminder: Reminder? = nil {
        didSet {
            
        }
    }
    
    func addReminder(reminder: Reminder) {
        createSystemReminder(reminder: reminder)
        saveReminder(reminder: reminder)
    }
    
    func saveReminder(reminder: Reminder) {
        modelContext.insert(reminder)
    }
    
    private func getDate(reminder: Reminder) -> Date {
        return switch reminder.type {
        case .shortTerm:
            Date().moved(by: 30, .minute)
        case .longTerm:
            Date().moved(by: 4, .hour)
        }
    }
    
    func createSystemReminder(reminder: Reminder) {
        let eventStore = EKEventStore()
        eventStore.requestFullAccessToReminders() { [weak self] granted, error in
            if let error {
                print(error.localizedDescription)
            } else {
                let systemReminder = EKReminder(eventStore: eventStore)
                let dueDate = self?.getDate(reminder: reminder)
                
                systemReminder.dueDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate ?? Date())
                systemReminder.title = reminder.text
                
                let defaultCalendar = eventStore.defaultCalendarForNewReminders()
                
                if let defaultCalendar {
                    systemReminder.calendar = defaultCalendar
                    systemReminder.alarms?.append(.init(absoluteDate: dueDate ?? Date()))
                    do {
                        try eventStore.save(systemReminder, commit: true)
                    } catch {
                        print("chuj dupa kamieni kupa")
                    }
                }
            }
        }
    }
}
