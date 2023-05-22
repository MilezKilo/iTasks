//
//  Header.swift
//  ToDoApp
//
//  Created by Майлс on 27.04.2023.
//

import SwiftUI

struct Header: View {
    
    //MARK: - PROPERTIES
    @Binding var currentDay: Date
    @Binding var showAddSection: Bool
    
    var body: some View {
        headerView
    }
}


//MARK: - EXTENSION
extension Header {
    private var headerView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Сегодня")
                        .ubuntu(30, .light)
                    
                    Text("Добро пожаловать!")
                        .ubuntu(14, .light)
                }
                .hAlignment(.leading)
                
                addButton
            }
            
            /// - Today date in String type
            Text(Date().toString("MMM YYYY"))
                .ubuntu(16, .medium)
                .hAlignment(.leading)
                .padding(.top, 15)
            
            /// - Current week row
            weekRow
        }
        .padding(15)
    }
    
    /// - Week row view that can change choosen day
    private var weekRow: some View {
        HStack(spacing: 0) {
            ForEach(Calendar.current.currentWeek) { weekDay in
                let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                VStack(spacing: 0) {
                    Text(weekDay.string.prefix(3))
                        .ubuntu(12, .medium)
                    Text(weekDay.date.toString("dd"))
                        .ubuntu(16, status ? .medium : .regular)
                }
                .foregroundColor(status ? .blue : .gray)
                .hAlignment(.center)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentDay = weekDay.date
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, -15)
    }
    
    /// - Button that open new view to add new task
    private var addButton: some View {
        Button(action: {
            withAnimation(.default) {
                showAddSection.toggle()
            }
        }) {
            HStack {
                Image(systemName: "plus")
                Text("Добавить")
                    .ubuntu(15, .regular)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(
                Capsule()
                    .fill(Color.blue.gradient)
            )
            .foregroundColor(.white)
        }
    }
}

//MARK: - PREVIEW
struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Header(currentDay: .constant(.init()), showAddSection: .constant(false))
                .preferredColorScheme(.light)
                .navigationBarHidden(true)
            
            Header(currentDay: .constant(.init()), showAddSection: .constant(false))
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
        }
    }
}
