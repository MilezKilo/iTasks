//
//  TasksSection.swift
//  ToDoApp
//
//  Created by Майлс on 02.02.2023.
//

import SwiftUI

struct TasksSection: View {
    
    //MARK: - PROPERTIES
    @EnvironmentObject private var todo: ToDoVM
    @State private var openAddView: Bool = false
    @State private var currentDay: Date = .init()
    
    var body: some View {
        ZStack {
            addTaskBody
            mainBody
        }
    }
}

//MARK: - EXTENSION
extension TasksSection {
    //VIEWS
    private var mainBody: some View {
        VStack {
            Header(currentDay: $currentDay, showAddSection: $openAddView)
            TimeLineView(currentDay: $currentDay)
        }
        .padding()
        .opacity(openAddView ? 0 : 1)
    }
    @ViewBuilder private var addTaskBody: some View {
        if openAddView {
            AddTaskSection(closeView: $openAddView)
        }
    }
}


//MARK: - PREVIEW
struct TasksSection_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                TasksSection()
                    .preferredColorScheme(.light)
                    .navigationBarHidden(true)
                    .environmentObject(ToDoVM())
            }
            
            NavigationView {
                TasksSection()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
                    .environmentObject(ToDoVM())
            }
        }
    }
}
