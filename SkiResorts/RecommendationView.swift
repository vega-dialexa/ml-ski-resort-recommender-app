//
//  RecommendationView.swift
//  SkiResorts
//
//  Created by Jaime Vega on 4/19/24.
//

import SwiftUI
import CoreML

struct RecommendationView: View {
    let resort: SkiResort
    var skiCostRecommender: SkiCostRecommender
    @State var recommendedResorts: [String] = [String]()
    
    init(resort: SkiResort) {
        self.resort = resort
        
        do {
            skiCostRecommender = try SkiCostRecommender(configuration: MLModelConfiguration())
        } catch {
            fatalError("Error initializing model: \(error)")
        }
    }
    
    var body: some View {
        VStack {
            Text("Recommendation")
                .font(.title)
                .fontWeight(.bold)
            Text("If you like \(resort.resortName), you might also like these resorts:")
                .padding(EdgeInsets(top: 10.0, leading: 50.0, bottom: 10.0, trailing: 50.0))
            List(recommendedResorts, id: \.self) { resort in
                Text(resort)
            }
            .onAppear() {
                loadRecommendations()
            }
        }
    }
    
    func loadRecommendations() {
        let input = SkiCostRecommenderInput(items: [resort.resortName : 5.0], k: 5)
        if let output = try? skiCostRecommender.prediction(input: input) {
            self.recommendedResorts = output.recommendations
        }
    }
}
