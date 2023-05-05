//
//  ListViewModel.swift
//  TodoList
//
//  Created by Oran Levi on 05/05/2023.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [itemModel] = []
    
    init() {
        getItems()
    }
    
    func getItems() {
        let newItems = [
            itemModel(title: "First", isCompleted: false),
            itemModel(title: "Second", isCompleted: true),
            itemModel(title: "third", isCompleted: false),
        ]
        items.append(contentsOf: newItems)
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to  )
    }
    
    func addItem(title:String){
        let newItem = itemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: itemModel){
        if let index = items.firstIndex(where: {$0.id == item.id}){
            items[index] = item.updateCompletion()
        }
    }
}
