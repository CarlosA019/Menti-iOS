//
//  ProfileView.swift
//  menti
//
//   Created by Carlos Alcala  01/06/24
//

import SwiftUI

struct ProfileView: View {
    @Binding var dynamicUser: String
    @State private var animateGradient: Bool = false
    @State private var textName: String = ""
    @State var textMonth: String = ""
    @State var textDay: String = ""
    @State var textYear: String = ""
    @State var textGender: String = ""
    @State var textPronouns: String = ""
    @State var textFT: String = ""
    @State var textIN: String = ""

    private let startColor: Color = Color(hex: 0x9097ff)
    private let endColor: Color = Color(hex: 0x000990)
    private let userNameKey = "userName"
    private let userMonthKey = "userMonth"
    private let userDayKey = "userDay"
    private let userYearKey = "userYear"
    private let userGenderKey = "userGender"
    private let userPronounsKey = "userPronouns"
    private let userFTKey = "userFT"
    private let userINKey = "userIN"

    var body: some View {
        VStack {
            Text("About me").font(.title).fontWeight(.black)
            Spacer()
            VStack {
                Text("How do your friends call you?")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                HStack {
                    TextField("First Name", text: $textName)
                        .padding(.all, 10)
                        .background(Color.white.opacity(0.8).cornerRadius(15.0))
                        .font(.headline)
                        .foregroundColor(.black)
                        .onChange(of: textName) { newValue in
                            dynamicUser = newValue
                            saveData(newValue, forKey: userNameKey)
                        }
                        .onAppear {
                            if let savedName = UserDefaults.standard.string(forKey: userNameKey) {
                                textName = savedName
                                dynamicUser = savedName
                            }
                        }
                    Text(",").font(.headline)
                }
            }
            HStack {
                Text("I was born on").font(.headline)
                TextField("Month", text: $textMonth)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8).cornerRadius(15.0))
                    .font(.headline)
                    .foregroundColor(.black)
                    .onChange(of: textMonth) { newValue in
                        saveData(newValue, forKey: userMonthKey)
                    }
                    .onAppear {
                        if let savedMonth = UserDefaults.standard.string(forKey: userMonthKey) {
                            textMonth = savedMonth
                        }
                    }
                
                TextField("Day", text: $textDay)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8).cornerRadius(15.0))
                    .font(.headline)
                    .foregroundColor(.black)
                    .onChange(of: textDay) { newValue in
                        saveData(newValue, forKey: userDayKey)
                    }
                    .onAppear {
                        if let savedDay = UserDefaults.standard.string(forKey: userDayKey) {
                            textDay = savedDay
                        }
                    }
                
                TextField("Year", text: $textYear)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8).cornerRadius(15.0))
                    .font(.headline)
                    .foregroundColor(.black)
                    .onChange(of: textYear) { newValue in
                        saveData(newValue, forKey: userYearKey)
                    }
                    .onAppear {
                        if let savedYear = UserDefaults.standard.string(forKey: userYearKey) {
                            textYear = savedYear
                        }
                    }
                
                Text(".").font(.headline)
            }
            HStack {
                Text("I identify as a").font(.headline)
                TextField("Gender", text: $textGender)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8).cornerRadius(15.0))
                    .font(.headline)
                    .foregroundColor(.black)
                    .onChange(of: textGender) { newValue in
                        saveData(newValue, forKey: userGenderKey)
                    }
                    .onAppear {
                        if let savedGender = UserDefaults.standard.string(forKey: userGenderKey) {
                            textGender = savedGender
                        }
                    }
                
                Text(", and I'd like").font(.headline)
            }
            HStack {
                Text("to be referred to as").font(.headline)
                TextField("Pronouns", text: $textPronouns)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8).cornerRadius(15.0))
                    .font(.headline)
                    .foregroundColor(.black)
                    .onChange(of: textPronouns) { newValue in
                        saveData(newValue, forKey: userPronounsKey)
                    }
                    .onAppear {
                        if let savedPronouns = UserDefaults.standard.string(forKey: userPronounsKey) {
                            textPronouns = savedPronouns
                        }
                    }
                
                Text(".").font(.headline)
            }
            HStack {
                Text("Currently, I am").font(.headline)
                TextField("ft", text: $textFT)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8).cornerRadius(15.0))
                    .font(.headline)
                    .foregroundColor(.black)
                    .onChange(of: textFT) { newValue in
                        saveData(newValue, forKey: userFTKey)
                    }
                    .onAppear {
                        if let savedFT = UserDefaults.standard.string(forKey: userFTKey) {
                            textFT = savedFT
                        }
                    }
                
                Text("and").font(.headline)
                TextField("in", text: $textIN)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8).cornerRadius(15.0))
                    .font(.headline)
                    .foregroundColor(.black)
                    .onChange(of: textIN) { newValue in
                        saveData(newValue, forKey: userINKey)
                    }
                    .onAppear {
                        if let savedIN = UserDefaults.standard.string(forKey: userINKey) {
                            textIN = savedIN
                        }
                    }
                
                Text("tall.").font(.headline)
            }
            Spacer()
        }
        .padding(.all, 30)
        .foregroundColor(.white)
        .background {
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
        }
    }

    // Function to save data to UserDefaults
    private func saveData(_ value: String, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(dynamicUser: .constant("Johnny")) // Use a dynamic value here
    }
}
