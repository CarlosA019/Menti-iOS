//
//  ListRowView.swift
//  ListApp
//
//   Created by Carlos Alcala  01/06/24
//

import SwiftUI
struct ListRowView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    var item: ItemModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.title3)
                    .bold()
                    
            }
            Spacer()
            Text("Next at \(item.time)") // Display the chosen time for the next dose
                .font(.subheadline)
                .bold()
                .foregroundColor(.teal)
        }
        .contentShape(Rectangle())
        .onTapGesture(count: 2) {
            withAnimation(.linear) {
                listViewModel.deleteItem(item: item)
            }
        }
        .contextMenu {
            Button(action: {
                listViewModel.deleteItem(item: item)
            }) {
                Text("Delete")
                Image(systemName: "trash")
            }
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var item1 = ItemModel(title: "First item", isCompleted: false, time: "9:00 AM", selectedDay: Date())
        static var item2 = ItemModel(title: "Second item", isCompleted: true, time: "10:30 AM", selectedDay: Date())

    
    static var previews: some View {
        Group {
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .environmentObject(ListViewModel()) // Add ListViewModel to the environment
        .previewLayout(.sizeThatFits)
    }
}
