//
//  ListView.swift
//  TodoList
//
//  Created by Oran Levi on 05/05/2023.
//

import SwiftUI

struct ListView: View {
    
    @State var item: [itemModel] = [
        itemModel(title: "First", isCompleted: false),
        itemModel(title: "Second", isCompleted: true),
        itemModel(title: "third", isCompleted: false),
    ]
    
    var body: some View {
        List{
            ForEach(item) { item in
                ListRowView(item: item)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Todo List 🗒️")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddView()))
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
    }
}


