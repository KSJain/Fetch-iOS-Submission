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
        
    func getDestinationViewFor(recipe: MealRecipe) -> RecipeDetailView {
        let vm = RecipeDetailViewModel(recipe: recipe, service: mealAPIService)
        return RecipeDetailView(viewModel: vm)
    }
    
    func getFeaturedRecipeViewModel() -> FeaturedRecipeViewModel {
        FeaturedRecipeViewModel(mealAPIService: mealAPIService)
    }
}
