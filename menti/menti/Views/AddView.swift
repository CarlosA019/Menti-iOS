//
//  AddView.swift
//  ListApp
//
//   Created by Carlos Alcala  01/06/24
//

import SwiftUI
import UserNotifications

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var listViewModel: ListViewModel

    @State private var medicationText: String = ""
    @State private var selectedDay = Date()
    @State private var selectedTime = Date()

    @State private var alertTitle: String = ""
    @State private var showAlert: Bool = false

    init(listViewModel: ListViewModel) {
        self.listViewModel = listViewModel
        listViewModel.requestNotificationAuthorization()
    }

    var body: some View {
        ScrollView {
            VStack {
                Text("Add a new medication")
                    .bold()

                TextField("Type medication", text: $medicationText)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color(hue: 0.635, saturation: 0.0, brightness: 0.953))
                    .cornerRadius(7)

                Text("When will you have to take it again?")
                    .frame(height: 40)
                    .bold()
                    .padding(.horizontal)
                
                DatePicker("Select Day", selection: $selectedDay, in: Date()..., displayedComponents: .date)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(hue: 0.635, saturation: 0.0, brightness: 0.953))
                    .cornerRadius(7)

                DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(hue: 0.635, saturation: 0.0, brightness: 0.953))
                    .cornerRadius(7)

                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(height: 35)
                        .frame(width: 65)
                        .background(Color.accentColor)
                        .cornerRadius(5)
                })
            }
            .padding(14)
        }
        .navigationTitle("Add Medication +")
        .alert(isPresented: $showAlert, content: getAlert)
    }

    func saveButtonPressed() {
        if textIsAppropriate() {
            // Combine selectedDay and selectedTime
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day], from: selectedDay)
            let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
            components.hour = timeComponents.hour
            components.minute = timeComponents.minute
            let combinedDate = calendar.date(from: components) ?? Date()

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let formattedTime = dateFormatter.string(from: combinedDate)

            listViewModel.addItem(title: medicationText, time: formattedTime, selectedDay: combinedDate)

            scheduleNotification(title: "Medication Reminder", body: "Time to take \(medicationText)", date: combinedDate)

            presentationMode.wrappedValue.dismiss()
        }
    }

    func textIsAppropriate() -> Bool {
        if medicationText.count < 2 {
            alertTitle = "Your medication name must be at least 2 characters long!"
            showAlert.toggle()
            return false
        }
        return true
    }

    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }

    func scheduleNotification(title: String, body: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date), repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView(listViewModel: ListViewModel())
        }
    }
}
