//
//  Date+.swift
//  addPlanner
//
//  Created by Linczewski, Mikolaj on 05/11/2024.
//
import Foundation

extension Date {
    func moved(by: Int, _ unit: Calendar.Component) -> Date {
        return Calendar.current.date(byAdding: unit, value: by, to: self) ?? Date()
    }

    mutating func move(by: Int, _ unit: Calendar.Component) {
        self = Calendar.current.date(byAdding: unit, value: by, to: self) ?? self
    }
}
