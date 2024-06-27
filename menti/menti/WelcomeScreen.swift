//
//  WelcomeScreen.swift
//  menti
//
//  Created by admin on 1/26/24.
//

    import SwiftUI
    import UserNotifications

    struct WelcomeScreen: View {
        @EnvironmentObject var listViewModel: ListViewModel
        @State private var navigateToContentView = false

        var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: 0x5C69FF), Color(hex: 0x909AFF)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack {
                    Image("menti-Image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)

                    Text("Welcome to Menti!")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)

                    Text("Want me to keep you on track \n with small reminders?")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 90)

                    Image("Notification-Image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250) // Adjust the size as needed
                        .padding(.bottom, 60)

                    Button("YES, PLEASE!") {
                        // Handle the button tap to request notification authorization
                        requestNotificationAuthorization { granted in
                            // Navigate to ContentView if permission is granted
                            if granted {
                                self.navigateToContentView = true
                            }
                        }
                    }
                    .foregroundColor(Color(hex: 0x9EA6FF))
                    .font(.headline)
                    .padding()
                    .background(Color.white) // White background
                    .cornerRadius(20)
                    .padding(.bottom, 60)
                }
            }
            .onAppear {
                // Check notification permission status when the view appears
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    DispatchQueue.main.async {
                        self.navigateToContentView = settings.authorizationStatus == .authorized
                    }
                }
            }
            .fullScreenCover(isPresented: $navigateToContentView) {
                ContentView()
            }
        }

        func requestNotificationAuthorization(completion: @escaping (Bool) -> Void) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    print("Notification authorization granted")
                } else {
                    print("Notification authorization denied")
                }
                completion(granted)
            }
        }
    }

    #Preview {
        WelcomeScreen()
    }
