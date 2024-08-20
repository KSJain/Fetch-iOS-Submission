//
//  DashboardViewModel.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/19/24.
//

import Foundation


@MainActor
final class DashboardViewModel: ObservableObject {
    let mealAPIService: any MealAPIServiceProtocol
    
    @Published var currentRecipe: MealRecipe?
    @Published var desserts: [MealRecipe] = []
    
    init(mealAPIService: any MealAPIServiceProtocol) {
        self.mealAPIService = mealAPIService
    }
    
    func getRecipe(id: String = "53049") {
        Task {
            self.currentRecipe = try await mealAPIService.getMealBy(id: id).meals.first
            
        }
    }
    
    func getDesserts() {
        Task {
            let meals = try await mealAPIService.getMealsByCategory("Dessert")
            desserts = meals.meals
            
            getRecipe()
        }
    }
}
