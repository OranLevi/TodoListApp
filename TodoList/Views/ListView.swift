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
                VStack{
                    sortSegment
                    listItems
                }
                
            }
        }.onAppear{
            editMode = .inactive
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Todo List 🗒️")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                listViewModel.items.isEmpty ? nil : EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("Add", destination: AddView())
            }
        })
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


extension ListView {
    
    private var listItems: some View {
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
                listViewModel.sortList()
            }
            .onMove { IndexSet, newIndex in
                listViewModel.moveItem(from: IndexSet, to: newIndex)
            }
        }
    }
    
    private var sortSegment: some View {
        Picker("Sort", selection: $listViewModel.selectedIndexSort) {
            ForEach(listViewModel.sortListArray.indices, id: \.self) { index in
                Text(listViewModel.sortListArray[index])
                    .tag(index)
            }
        }
        .cornerRadius(10)
        .onChange(of: listViewModel.selectedIndexSort, perform: { value in
            listViewModel.selectedIndexSort = value
        })
        .padding(4)
        .padding(.horizontal)
        .pickerStyle(.segmented)
        
    }
}
