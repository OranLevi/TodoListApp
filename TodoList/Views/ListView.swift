//
//  ListView.swift
//  TodoList
//
//  Created by Oran Levi on 05/05/2023.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewMode: ListViewModel
    
    var body: some View {
        ZStack{
            if listViewMode.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List{
                    ForEach(listViewMode.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewMode.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete { IndexSet in
                        listViewMode.deleteItem(indexSet: IndexSet)
                    }
                    .onMove { IndexSet, newIndex in
                        listViewMode.moveItem(from: IndexSet, to: newIndex)
                    }
                }
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
        }.environmentObject(ListViewModel())
    }
}


