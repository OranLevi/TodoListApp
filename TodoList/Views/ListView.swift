//
//  ListView.swift
//  TodoList
//
//  Created by Oran Levi on 05/05/2023.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var editMode: EditMode = .inactive
    
    var body: some View {
        ZStack{
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List{
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete { IndexSet in
                        listViewModel.deleteItem(indexSet: IndexSet)
                    }
                    .onMove { IndexSet, newIndex in
                        listViewModel.moveItem(from: IndexSet, to: newIndex)
                    }
                }
            }
        }.onAppear{
            editMode = .inactive
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Todo List 🗒️")
        .navigationBarItems(
            leading: listViewModel.items.isEmpty ? nil : EditButton(),
            trailing: NavigationLink("Add", destination: AddView()))
        .environment(\.editMode, $editMode)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }.environmentObject(ListViewModel())
    }
}


