//
//  Model.swift
//  TodoList
//
//  Created by Oran Levi on 05/05/2023.
//

import Foundation

struct itemModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let isCompleted: Bool
}
