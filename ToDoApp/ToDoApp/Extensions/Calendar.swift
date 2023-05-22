//
//  Calendar.swift
//  ToDoApp
//
//  Created by Майлс on 27.04.2023.
//

import Foundation

//MARK: - EXTENSION
extension Calendar {
    /// - Returns 24 hours in day
    var hours: [Date] {
        let startOfDay = startOfDay(for: Date())
        var hours: [Date] = []
        for index in 0..<24 {
            if let data = self.date(byAdding: .hour, value: index, to: startOfDay) {
                hours.append(data)
            }
        }
        
        return hours
    }
    
    /// - Returns current week in array format
    var currentWeek: [WeekDay] {
        guard let firstDayWeek = self.dateInterval(of: .weekOfMonth, for: Date())?.start else {return  []}
        var week: [WeekDay] = []
        for index in 0...7 {
            if let day = self.date(byAdding: .day, value: index, to: firstDayWeek) {
                let weekDaySymbol: String = day.toString("EEEE")
                let isToday = self.isDateInToday(day)
                week.append(.init(string: weekDaySymbol, date: day, isToday: isToday))
            }
        }
        return week
    }
    
    /// - Used to store data of each week day
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var string: String
        var date: Date
        var isToday: Bool = false
    }
}
