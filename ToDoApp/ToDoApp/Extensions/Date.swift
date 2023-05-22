//
//  Date.swift
//  ToDoApp
//
//  Created by Майлс on 27.04.2023.
//

import Foundation

//MARK: - EXTENSION
extension Date {
    /// - Returns time formatting in string type
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /// - Returns date and time in string type
    static func getDateAndTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
    
    /// - Returns time in string type
    static func getTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
