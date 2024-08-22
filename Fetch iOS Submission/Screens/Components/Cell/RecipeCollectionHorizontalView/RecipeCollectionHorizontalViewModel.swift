//
//  RecipeCollectionHorizontalViewModel.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/22/24.
//

import Foundation

final class RecipeCollectionHorizontalViewModel: ObservableObject {
    private let service: MealAPIServiceProtocol
    @Published var recipes: [MealRecipe]
    
    init(mealAPIService: MealAPIServiceProtocol, recipes: [MealRecipe]) {
        self.service = mealAPIService
        self.recipes = recipes
    }
    
    @MainActor
    func getRecipeDetailViewModel(recipe: MealRecipe) -> RecipeDetailViewModel {
        RecipeDetailViewModel(recipe: recipe, service: service)
    }
}
