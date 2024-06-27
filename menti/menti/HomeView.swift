//
//  HomeView.swift
//  menti
//
//  Created by Carlos Alcala  01/06/24
//

import SwiftUI

struct HomeView: View {
    @Binding var dynamicUser: String
    @State private var animateGradient: Bool = false
    private let startColor: Color = Color(hex: 0xa299ff)
    private let endColor: Color = Color(hex: 0xa3e8ec)
    
    // UserDefaults key for the user's name
    private let userNameKey = "userName"
    
    var body: some View {
        VStack {
            Image("launchscreen")
            Text("Hi " + dynamicUser)
                .font(.system(size: 40, weight: .black, design: .rounded))
            
            VStack {
                Spacer()
                Text("\"" + quote + "\"")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 30, weight: .bold, design: .serif))
                Text("\n")
                Text("- " + author)
                    .font(.system(size: 25, weight: .light, design: .serif))
                    .italic()
                Spacer()
            }
        }
        .padding(.all, 30)
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background {
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .onAppear {
                    // Gradient animation with a duration of 15 seconds
                    withAnimation(.easeInOut(duration: 15).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                    
                    // Check UserDefaults for the user's name and update dynamicUser
                    if let savedName = UserDefaults.standard.string(forKey: userNameKey) {
                        dynamicUser = savedName
                    }
                    
                    // Quote display duration of 3600 seconds (1 hour)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3600) {
                        // Trigger the next quote or update your data accordingly
                    }
                    
                    print("HomeView onAppear - user:", dynamicUser)
                }
        }
    }
}

// This is an extension for Color
extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dynamicUser: .init(get: { "Carlos" }, set: { _ in }))
    }
}
