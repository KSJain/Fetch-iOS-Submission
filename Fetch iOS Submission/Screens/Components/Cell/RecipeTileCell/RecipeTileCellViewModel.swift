//
//  RecipeTileCellViewModel.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/22/24.
//

import Foundation

@MainActor
final class RecipeTileCellViewModel: ObservableObject {
    let mealServiceAPI: MealAPIServiceProtocol
    @Published var recipe: MealRecipe
    @Published var areaText: String = ""
    
    init(recipe: MealRecipe, mealServiceAPI: MealAPIServiceProtocol) {
        self.mealServiceAPI = mealServiceAPI
        self.recipe = recipe
        
        getDetailedRecipe()
    }
    
    func getDetailedRecipe(id: String = "") {
        
        var recipeId = ""
        if !id.isEmpty {
            recipeId = id
        } else if let id = recipe.id {
            recipeId = id
        }
        
        Task {
            if let meals = try await mealServiceAPI.getMealBy(id: recipeId).meals.first {
                recipe = meals
                
                if let area = meals.strArea {
                    areaText = area
                }
            }
        }
        
    }
}
