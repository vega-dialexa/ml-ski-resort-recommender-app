//
//  ContentView.swift
//  SkiResorts
//
//  Created by Jaime Vega on 4/17/24.
//

import SwiftUI

struct SkiResort: Decodable {
    let resortName: String
    let state: String
    let region: String
}

struct ContentView: View {
    @State private var resorts = [SkiResort]()
   
    var body: some View {
        NavigationStack {
            Text("Ski Resorts")
                .font(.title)
                .fontWeight(.bold)
            List(resorts, id: \.resortName) { resort in
                NavigationLink(destination: RecommendationView(resort: resort)) {
                    Text(resort.resortName)
                }
            }
        }
        .padding()
        .onAppear {
            loadJSONData()
        }
    }
    
    func loadJSONData() {
        let url = Bundle.main.url(forResource: "ski-resorts-list", withExtension: "json")
        if let url = url {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let resorts = try decoder.decode([SkiResort].self, from: data)
                self.resorts = resorts
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
