//
//  NotificationManager.swift
//  ToDoApp
//
//  Created by Майлс on 03.03.2023.
//

import Foundation
import NotificationCenter

class NotificationManager: NotificationCenter {
    static var instance: NotificationManager = NotificationManager()
    
    /// - Request from user authorization to send notifications to his iPhone
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.badge, .alert, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if success {
                print("All good!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    /// - Append new notification to schedule
    func scheduleNotification(title: String, body: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.badge = 1
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification add error: \(error.localizedDescription)")
            }
        }
    }
}
