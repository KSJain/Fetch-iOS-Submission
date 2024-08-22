//
//  FeaturedRecipeViewModel.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/22/24.
//

import Foundation

@MainActor
final class FeaturedRecipeViewModel: ObservableObject {
    private let mealAPIService: MealAPIServiceProtocol
    @Published var recipes: [MealRecipe] = []
    @Published var recipeViewModel: RecipeCollectionHorizontalViewModel? = nil
    
    init(mealAPIService: MealAPIServiceProtocol) {
        self.mealAPIService = mealAPIService
        getFeaturedRecipes()
    }
    
    func getFeaturedRecipes() {
        Task {
            var collection = [MealRecipe]()
            recipes = []
            for _ in 0...5 {
                if let recipe = try await mealAPIService.getRandomMeal().meals.first {
                    collection.append(recipe)
                }
            }
            recipes = collection
            getRecipeCollectionHorizontalViewModel()
        }
    }

    func getRecipeCollectionHorizontalViewModel() {
        recipeViewModel = RecipeCollectionHorizontalViewModel(mealAPIService: mealAPIService, recipes: recipes)
    }
}
