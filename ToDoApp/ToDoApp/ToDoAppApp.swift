//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Майлс on 02.02.2023.
//

import SwiftUI

@main
struct ToDoAppApp: App {
    
    @StateObject private var vm: ToDoVM = ToDoVM()
    @State private var showLaunchScreen: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if showLaunchScreen {
                SquaresLaunchScreen(showLaunchScreen: $showLaunchScreen)
            } else {
                NavigationView {
                    ContentView()
                        .onAppear(perform: NotificationManager.instance.requestAuthorization)
                        .navigationBarHidden(true)
                        .environmentObject(vm)
                }
            }
        }
    }
}
