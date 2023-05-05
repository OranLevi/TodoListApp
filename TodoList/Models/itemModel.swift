//
//  Model.swift
//  TodoList
//
//  Created by Oran Levi on 05/05/2023.
//

import Foundation

struct itemModel: Identifiable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString ,title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> itemModel {
        return itemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
