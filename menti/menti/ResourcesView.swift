///
//  ResourcesView.swift
//  menti
//
//   Created by Carlos Alcala  01/06/24
//

import SwiftUI

struct ResourcesView: View {
    @State var resources = countryList
    var body: some View {
        VStack {
            Text("Resources").font(.title).fontWeight(.black)
            NavigationView {
                List {
                    DisclosureGroup("Need some support?") {
                        Button(action: {
                        // Make a phone call
                            if let url = URL(string: "tel://988") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("Call 988")
                                .foregroundColor(.red)
                                .bold()
                        }
                    }
                    .foregroundColor(.red)
                    .padding()
                    .multilineTextAlignment(.center)
                    .bold()
                    
                    
                    ForEach(resources, id: \.self) { country in NavigationLink(destination:
                            VStack {
                        Text(country[0]).font(.title).fontWeight(.black).padding()
                        
                            Text(country[1]).padding()
                        Link("More about " + country[0].lowercased(), destination: URL(string: country[2])!).padding()

                    }.padding(.all, 30)) {
                        Image(systemName: "")
                        Text (country[0])
                    }.padding()
                    }
                }
            }
        }
    }
}

#Preview {
    ResourcesView()
}
