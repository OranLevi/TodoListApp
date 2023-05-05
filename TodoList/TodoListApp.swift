//
//  TodoListApp.swift
//  TodoList
//
//  Created by Oran Levi on 05/05/2023.
//

import SwiftUI

@main
struct TodoListApp: App {
    
    @StateObject var listViewMode: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewMode)
        }
    }
}
