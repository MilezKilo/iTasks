//
//  ToDoVM.swift
//  ToDoApp
//
//  Created by Майлс on 02.02.2023.
//

import SwiftUI
import CoreData

class ToDoVM: ObservableObject {
    
    //COREDATA PROPERTIES
    @Published var todoItems: [ToDoEntity] = []
    let container: NSPersistentContainer
    
    
    //OTHER PROPERTIES
    @Published var tasksTypes: [String] = ["Покупки", "Рабочие дела", "Домашние дела", "Учеба"]
    static var currentColor: Color = .red
    
    init() {
        container = NSPersistentContainer(name: "ToDoItem")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("CONTAINER LOADING ERROR: \(error.localizedDescription)")
            }
        }
        fetchData()
    }
    
    //PRIVATE COREDATA METHODS
    private func fetchData() {
        let request = NSFetchRequest<ToDoEntity>(entityName: "ToDoEntity")
        do {
            todoItems = try container.viewContext.fetch(request)
        } catch let error {
            print("FETCHING DATA ERROR: \(error.localizedDescription)")
        }
    }
    private func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        } catch let error {
            print("SAVING DATA ERROR: \(error.localizedDescription)")
        }
    }
    
    //NON PRIVATE COREDATA METHODS
    /// - Add a new task, in start task isnt done
    func addTask(title: String, overview: String, type: String, date: Date) {
        let newTask = ToDoEntity(context: container.viewContext)
        newTask.title = title
        newTask.overview = overview
        newTask.type = type
        newTask.time = date
        newTask.status = false
        NotificationManager.instance.scheduleNotification(title: title, body: overview ,date: date)
        saveData()
    }
    /// - Complete task with animation and then delete it
    func doneTask(_ task: ToDoEntity) {
        withAnimation(.default) {
            task.status = true
            saveData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.default) {
                self.container.viewContext.delete(task)
                self.saveData()
            }
        }
    }
    
    
    //NON PRIVATE METHODS
    /// - Returns color based on task type
    func returnTaskColor(_ text: String) -> Color {
        switch text {
        case "Покупки":
            return .red
        case "Рабочие дела":
            return .blue
        case "Домашние дела":
            return .green
        case "Учеба":
            return .brown
        default:
            return .red
        }
    }
}
