//
//  MedView.swift
//  menti
//
//  Created by Carlos Alcala  01/06/24
//

import SwiftUI

struct MedView: View {
    @StateObject var listViewModel: ListViewModel = ListViewModel()

    var body: some View {
        NavigationView {
            ListView()
                .environmentObject(listViewModel)
        }
        .navigationTitle("Today's Medications")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddView(listViewModel: listViewModel))
        )
    }
}


    #Preview {
        MedView()
    }
