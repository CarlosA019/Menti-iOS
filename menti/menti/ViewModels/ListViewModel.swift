//
//  ListViewModel.swift
//  ListApp
//
//   Created by Carlos Alcala  01/06/24

import UserNotifications
import Foundation

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }

    let itemsKey: String = "items_list"

    init() {
        getItems()
        requestNotificationAuthorization()
    }

    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }

        self.items = savedItems
    }

    var sortedItems: [ItemModel] {
        return items.sorted {
            if let date1 = $0.selectedDay, let date2 = $1.selectedDay {
                if date1 != date2 {
                    return date1 < date2
                } else {
                    return $0.time < $1.time
                }
            }
            return false
        }
    }

    func deleteItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }

    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }

    func addItem(title: String, time: String, selectedDay: Date?) {
        let newItem = ItemModel(title: title, isCompleted: false, time: time, selectedDay: selectedDay)
        items.append(newItem)
    }

    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }

    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }

    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification authorization granted")
            } else {
                print("Notification authorization denied")
            }
        }
    }
}
