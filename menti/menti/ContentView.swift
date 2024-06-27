//
//  ContentView.swift
//  menti
//
//   Created by Carlos Alcala  01/06/24
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @State var selection = 0
    @State var dynamicUser = ""
    @State private var translation: CGFloat = .zero

    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $selection) {
                HomeView(dynamicUser: $dynamicUser)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }.tag(0)
                MedView()
                    .tabItem {
                        Label("Med Tracker", systemImage: "pill.circle.fill")
                    }.tag(1)
                ResourcesView()
                    .tabItem {
                        Label("Resources", systemImage: "magnifyingglass.circle.fill")
                    }.tag(2)
                ProfileView(dynamicUser: $dynamicUser)
                    .tabItem {
                        Label("Profile", systemImage: "brain.head.profile.fill")
                    }.tag(3)
            }
            .onAppear() {
                UITabBar.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.6)
            }
            .background(Color.white)
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(Color.white, for: .tabBar)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        translation = value.translation.width
                    }
                    .onEnded { value in
                        let swipeThreshold: CGFloat = 50

                        if abs(translation) > swipeThreshold {
                            if translation < 0 {
                                // Swipe left
                                if selection < 3 {
                                    selection += 1
                                }
                            } else {
                                // Swipe right
                                if selection > 0 {
                                    selection -= 1
                                }
                            }
                        }
                        translation = .zero
                    }
            )
        }
    }
}

#Preview {
    ContentView()
}
