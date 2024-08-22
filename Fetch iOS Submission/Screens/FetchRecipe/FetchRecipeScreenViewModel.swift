//
//  FetchRecipeScreenViewModel.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/19/24.
//

import Foundation


@MainActor
final class FetchRecipeScreenViewModel: ObservableObject {
    let mealAPIService: any MealAPIServiceProtocol
    
    @Published var catogorisedMeals: [MealRecipe] = []
    @Published var featuredRecipes: [MealRecipe] = []
    @Published var mealCatogries: [MealCategory] = []
    @Published var selectedCategory: MealCategory = MealCategory.DevData.mealCategory
    
    init(mealAPIService: any MealAPIServiceProtocol) {
        self.mealAPIService = mealAPIService
    }
    
    func getMealForCategory(_ categoryStr: String) {
        Task {
            let meals = try await mealAPIService.getMealsByCategory(categoryStr)
            catogorisedMeals = meals.meals
        }
    }
    
    func getFeaturedRecipes() {
        Task {
            var collection = [MealRecipe]()
            for _ in 0...5 {
                if let recipe = try await mealAPIService.getRandomMeal().meals.first {
                    collection.append(recipe)
                }
            }
            featuredRecipes = collection
        }
    }
    
    func getCategories() {
        Task { [weak self] in
            guard let self else { return }
            
            let mealCatogries = try await self.mealAPIService.listAllCategories().categories
            let filtered = mealCatogries.filter({$0.id != self.selectedCategory.id})
            self.mealCatogries = [self.selectedCategory] + filtered
        }
    }
    
    func setCategory(category: MealCategory) {
        selectedCategory = category
        
        let filtered = mealCatogries.filter({$0.id != category.id})
        mealCatogries = [selectedCategory] + filtered
        
        getMealForCategory(category.strCategory ?? "")
    }
    
    func getRecipeCollectionHorizontal() -> RecipeCollectionHorizontal {
        let vm = RecipeCollectionHorizontalViewModel(service: mealAPIService, recipes: featuredRecipes)
        return RecipeCollectionHorizontal(viewModel: vm)
    }
    
    func getDestinationViewFor(recipe: MealRecipe) -> RecipeDetailView {
        let vm = RecipeDetailViewModel(recipe: recipe, service: mealAPIService)
        return RecipeDetailView(viewModel: vm)
    }
}
