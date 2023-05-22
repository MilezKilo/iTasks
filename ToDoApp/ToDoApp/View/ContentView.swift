//
//  ContentView.swift
//  ToDoApp
//
//  Created by Майлс on 02.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - PROPERTIES
    @EnvironmentObject private var todo: ToDoVM
    
    //MARK: - BODY
    var body: some View {
        TasksSection()
    }
}

//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ContentView()
                    .preferredColorScheme(.light)
                    .environmentObject(ToDoVM())
                    .navigationBarHidden(true)
            }
            
            NavigationView {
                ContentView()
                    .preferredColorScheme(.dark)
                    .environmentObject(ToDoVM())
                    .navigationBarHidden(true)
            }
        }
    }
}
