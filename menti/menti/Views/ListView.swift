//
//  ListView.swift
//  ListApp
//
//   Created by Carlos Alcala  01/06/24
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel

    var body: some View {
        NavigationView {
            ZStack {
                //background gradient
                LinearGradient(gradient: Gradient(colors: [Color(hex: 0xccccff), Color(hex: 0xffda96)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack {
                    if listViewModel.items.isEmpty {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .frame(width: 350, height: 300)

                                Text("It seems there are no pending Medications. \n \n Press the Add button at the top to add more.")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                            .padding(.bottom)
                        }
                        .padding(.bottom)
                        
                    } else {
                        List {
                            ForEach(listViewModel.items) { item in
                                ListRowView(item: item)
                                    .padding(9)
                            }
                            .onMove(perform: listViewModel.moveItem)
                        }
                        .listStyle(PlainListStyle()) // Set the list style if needed
                        .cornerRadius(20) // Set the corner radius for the list
                        .background(Color.white) // list's background color
                        .cornerRadius(20)
                        .padding([.leading, .trailing])
                        
                            Text("* To complete an item, simply \n double-tap it!")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .bold()
                                .padding([.leading, .trailing])
                                .background(Color.clear.cornerRadius(20)) // Ensure the background matches the list's background
                            .padding([.bottom , .top],  3)
                        
                    }
                }
                .navigationTitle("Today's Medications")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing:
                        NavigationLink("Add", destination: AddView(listViewModel: listViewModel))
                )
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(ListViewModel())
    }
}

// Helper extension to create Color from hex
extension Color {
    init(hex: UInt) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0
        )
    }
}
