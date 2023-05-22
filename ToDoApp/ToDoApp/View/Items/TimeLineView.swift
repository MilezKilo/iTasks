//
//  TimeLineView.swift
//  ToDoApp
//
//  Created by Майлс on 02.05.2023.
//

import SwiftUI
import CoreData

struct TimeLineView: View {
    //MARK: - PROPERTIES
    @Binding var currentDay: Date
    @EnvironmentObject private var todo: ToDoVM
    
    
    //MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            timeLine
                .padding(15)
        }
    }
}


//MARK: - EXTENSION
extension TimeLineView {
    private var timeLine: some View {
        ScrollViewReader { proxy in
            let hours = Calendar.current.hours
            let midHour = hours[hours.count / 2]
            VStack {
                ForEach(hours, id: \.self) { hour in
                    timeLineRow(hour)
                        .id(hour)
                }
            }
            .onAppear {
                proxy.scrollTo(midHour)
            }
        }
    }
    @ViewBuilder func timeLineRow(_ date: Date) -> some View {
        HStack(alignment: .top) {
            Text(date.toString("h a"))
                .ubuntu(14, .regular)
                .frame(width: 45, alignment: .leading)
            
            /// - Filtering Tasks
            let calendar = Calendar.current
            let filteredTasks = todo.todoItems.filter {
                if let hour = calendar.dateComponents([.hour], from: date).hour,
                   let taskHour = calendar.dateComponents([.hour], from: $0.time!).hour, hour == taskHour && calendar.isDate($0.time!, inSameDayAs: currentDay) {
                    return true
                }
                return false
            }
            if filteredTasks.isEmpty {
                Rectangle()
                    .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 5))
                    .frame(height: 0.5)
                    .offset(y: 10)
            } else {
                /// - Task view
                VStack(spacing: 10) {
                    ForEach(filteredTasks) { task in
                        taskRow(task: task)
                    }
                }
            }
        }
        .hAlignment(.leading)
        .padding(.vertical, 15)
    }
    @ViewBuilder func taskRow(task: ToDoEntity) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(task.title!)
                    .ubuntu(16, .regular)
                .foregroundColor(todo.returnTaskColor(task.type!))
                Spacer()
                Button(action: {
                    todo.doneTask(task)
                }) {
                    ZStack {
                        Circle()
                            .stroke()
                            .frame(width: 17.5, height: 17.6)
                            .foregroundColor(todo.returnTaskColor(task.type!))
                        if task.status {
                            Circle()
                                .frame(width: 12.5, height: 12.5)
                                .foregroundColor(todo.returnTaskColor(task.type!))
                        }
                    }
                }
            }
            
            Text(task.overview!)
                .ubuntu(14, .light)
                .foregroundColor(todo.returnTaskColor(task.type!).opacity(0.8))
            
            Text(task.type!)
                .ubuntu(14, .light)
                .foregroundColor(todo.returnTaskColor(task.type!).opacity(0.8))
            
            Text(Date.getTime(date: task.time!))
                .ubuntu(14, .light)
                .foregroundColor(todo.returnTaskColor(task.type!).opacity(0.8))
            
        }
        .hAlignment(.leading)
        .padding(12)
        .background {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(todo.returnTaskColor(task.type!))
                    .frame(width: 4)
                
                Rectangle()
                    .fill(todo.returnTaskColor(task.type!).opacity(0.25))
            }
        }
    }
}

//MARK: - PREVIEW
struct TimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimeLineView(currentDay: .constant(.init()))
                .preferredColorScheme(.light)
                .navigationBarHidden(true)
                .environmentObject(ToDoVM())
            
            TimeLineView(currentDay: .constant(.init()))
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
                .environmentObject(ToDoVM())
        }
    }
}
