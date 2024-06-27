//
//  mentiApp.swift
//  menti
//
//  Created by Carlos Alcala  01/06/24
//

import SwiftUI

public var quote = "And if today all you did was hold yourself together, I'm proud of you."
public var author = "Menti"

@main
struct mentiApp: App {
    public var user = ""
    var listViewModel = ListViewModel()

    var body: some Scene {
        WindowGroup {
            WelcomeScreen()
                .environmentObject(listViewModel)
        }
    }

    func onStart() {
        struct Response: Codable {
            let q: String
            let a: String
            let h: String
        }

        if let url = URL(string: "https://zenquotes.io/api/today") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode([Response].self, from: data)
                        
                        if let firstQuote = res.first {
                            quote = firstQuote.q
                            author = firstQuote.a
                        } else {
                            // If the API doesn't provide a quote, set a default one
                            quote = "And if today all you did was hold yourself together, I'm proud of you."
                            author = "Menti"
                        }
                    } catch let error {
                        // Error handling
                        print(error)
                    }
                }
            }.resume()
        }
    }

    init() {
        onStart()
    }
}

