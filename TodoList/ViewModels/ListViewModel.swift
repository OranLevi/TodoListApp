//
//  ListViewModel.swift
//  TodoList
//
//  Created by Oran Levi on 05/05/2023.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    
    @Published var items: [itemModel] = [] {
        didSet{
            saveItems()
        }
    }
    
    @Published var selectedIndexSort = 0
    @Published var sortListArray = ["A-Z", "Completed", "Todo"]
    
    private var cancellables = Set<AnyCancellable>()
    
    let itemsKey = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let saveItems = try? JSONDecoder().decode([itemModel].self, from: data)
        else { return }
        
        self.items = saveItems
        sortList()
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
        saveItems()
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title:String){
        let newItem = itemModel(title: title, isCompleted: false)
        items.append(newItem)
        sortList()
    }
    
    func updateItem(item: itemModel){
        if let index = items.firstIndex(where: {$0.id == item.id}){
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems(){
        if let encodeData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodeData, forKey: itemsKey)
        }
    }
    
    func sortList(){
        $selectedIndexSort
            .sink { [weak self] _ in
                switch self?.selectedIndexSort {
                case 0:
                    self?.items.sort(by: {$0.title < $1.title})
                case 1:
                    self?.items.sort(by: {$0.isCompleted && !$1.isCompleted})
                case 2:
                    self?.items.sort(by: {$1.isCompleted && !$0.isCompleted})
                default: break
                }
            }
            .store(in: &cancellables)
    }
}
