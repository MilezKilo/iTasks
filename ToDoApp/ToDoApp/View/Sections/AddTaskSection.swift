//
//  AddTaskSection.swift
//  ToDoApp
//
//  Created by Майлс on 03.02.2023.
//

import SwiftUI

struct AddTaskSection: View {
    
    //MARK: - PROPERTIES
    /// - Environment and binding properties
    @EnvironmentObject private var todo: ToDoVM
    @Binding var closeView: Bool
    
    /// - Data properties of current view
    @State private var title: String = ""
    @State private var overview: String = ""
    @State private var type: String = ""
    @State private var date: Date = .init()
        
    /// - Custom Colors
    @State private var animatedColor: Color = ToDoVM.currentColor
    
    var body: some View {
        VStack(alignment: .leading) {
            upperView
            lowerView
        }
        .vAlignment(.top)
    }
}


//MARK: - EXTENSION
extension AddTaskSection {
    //VIEWS METHODS
    @ViewBuilder func titleView(_ value: String, _ color: Color = .white.opacity(0.7)) -> some View {
        Text(value)
            .ubuntu(12, .regular)
            .foregroundColor(color)
    }
    
    //VIEWS
    private var dateAndTime: some View {
        HStack(alignment: .bottom, spacing: 12) {
            HStack(spacing: 12) {
                Text(date.toString("EEEE dd MMMM"))
                    .ubuntu(16, .regular)
                
                Image(systemName: "calendar")
                    .foregroundColor(.white)
                    .font(.title3)
                    .overlay {
                        DatePicker("", selection: $date, displayedComponents: [.date])
                            .blendMode(.destinationOver)
                    }
            }
            .offset(y: -5)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .fill(Color.white.opacity(0.7))
                    .frame(height: 1)
                    .offset(y: 5)
            }
            
            HStack(spacing: 12) {
                Text(date.toString("hh:mm a"))
                    .ubuntu(16, .regular)
                
                Image(systemName: "clock")
                    .foregroundColor(.white)
                    .font(.title3)
                    .overlay {
                        DatePicker("", selection: $date, displayedComponents: [.hourAndMinute])
                            .blendMode(.destinationOver)
                    }
            }
            .offset(y: -5)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .fill(Color.white.opacity(0.7))
                    .frame(height: 1)
                    .offset(y: 5)
            }
        }
    }
    private var categories: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: 3), spacing: 15) {
            ForEach(todo.tasksTypes, id: \.self) { type in
                Text(type)
                    .ubuntu(12, .regular)
                    .hAlignment(.center)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(todo.returnTaskColor(type).opacity(self.type == type ? 0.25 : 0.1)))
                    .foregroundColor(todo.returnTaskColor(type))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.default) {
                            self.animatedColor = todo.returnTaskColor(type)
                            self.type = type
                        }
                    }
            }
        }
        .padding(.top, 5)
    }
    private var addButton: some View {
        Button(action: {
            todo.addTask(
                title: title,
                overview: overview,
                type: type,
                date: date)
            withAnimation(.default) {
                closeView.toggle()
            }
        }) {
            Text("Создать задачу")
                .ubuntu(16, .regular)
                .foregroundColor(.white)
                .padding(.vertical, 15)
                .hAlignment(.center)
                .background {
                    Capsule()
                        .fill(animatedColor)
                }
        }
        .vAlignment(.bottom)
        .disabled(title == "")
        .opacity(title == "" ? 0.6 : 1)
    }
    
    private var upperView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                withAnimation(.default) {
                    closeView.toggle()
                }
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .contentShape(Rectangle())
            }
            
            Text("Создать задачу")
                .ubuntu(28, .light)
                .foregroundColor(.white)
                .padding(.vertical, 15)
            
            titleView("Название")
            
            TextField("Введите задачу", text: $title)
                .ubuntu(16, .regular)
                .tint(Color.white)
                .padding(.top, 2)
            
            Divider()
                .background(.white)
            
            titleView("Дата")
                .padding(.top, 15)
            
            dateAndTime
            
        }
        .environment(\.colorScheme, .dark)
        .hAlignment(.leading)
        .padding(15)
        .background(animatedColor.ignoresSafeArea())
    }
    private var lowerView: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleView("Описание", .gray)
            
            TextField("О вашей задаче", text: $overview)
                .ubuntu(16, .regular)
                .padding(.top, 2)
            
            Rectangle()
                .fill(Color.white.opacity(0.7))
                .frame(height: 1)
            
            titleView("Категория", .gray)
                .padding(.top, 15)
            
            categories
            
            addButton
        }
        .padding(15)
    }
}


//MARK: - EXTENSION
struct AddTaskSection_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AddTaskSection(closeView: .constant(true))
                    .environmentObject(ToDoVM())
                    .preferredColorScheme(.light)
                    .navigationBarHidden(true)
            }
            
            NavigationView {
                AddTaskSection(closeView: .constant(false))
                    .environmentObject(ToDoVM())
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
            }
        }
    }
}
