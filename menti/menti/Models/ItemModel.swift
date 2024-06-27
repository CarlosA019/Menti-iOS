//
//  ItemModel.swift
//  ListApp
//
//   Created by Carlos Alcala  01/06/24
//

import Foundation

struct ItemModel: Identifiable, Codable {
    var id: String
    var title: String
    var isCompleted: Bool
    var time: String
    var selectedDay: Date?

    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, time: String, selectedDay: Date?, timestamp: Date = Date()) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.time = time
        self.selectedDay = selectedDay
    }


    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, time: time, selectedDay: selectedDay)
    }
}
