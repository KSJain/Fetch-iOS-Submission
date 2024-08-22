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
    
    @Published var featuredRecipeViewModel: FeaturedRecipeViewModel
    
    @Published var catogorisedMeals: [MealRecipe] = []
    @Published var featuredRecipes: [MealRecipe] = []
    @Published var mealCatogries: [MealCategory] = []
    @Published var selectedCategory: MealCategory = MealCategory.DevData.mealCategory {
        didSet {
            getMealForCategory(selectedCategory)
        }
    }
    
    init(mealAPIService: any MealAPIServiceProtocol) {
        self.mealAPIService = mealAPIService
        self.featuredRecipeViewModel = FeaturedRecipeViewModel(mealAPIService: mealAPIService)
    }
    
    func getMealForCategory(_ category: MealCategory) {
        guard let categoryStr = category.strCategory else { return }
        Task {
            let meals = try await mealAPIService.getMealsByCategory(categoryStr)
            catogorisedMeals = meals.meals
            updateCategories()
        }
    }
    
    func getCategories() {
        Task { [weak self] in
            guard let self else { return }
            mealCatogries = try await self.mealAPIService.listAllCategories().categories
            updateCategories()
        }
    }
    
    func setCategory(category: MealCategory) {
        guard
            let strCategory = category.strCategory,
            !strCategory.isEmpty
        else { return }
        selectedCategory = category
        getMealForCategory(category)
        updateCategories()
    }
    
    func updateCategories() {
        guard let id = selectedCategory.id else { return }
        let filtered = mealCatogries.filter({$0.id != id})
        mealCatogries = [selectedCategory] + filtered
    }
        
    func getDestinationViewFor(recipe: MealRecipe) -> RecipeDetailView {
        let vm = RecipeDetailViewModel(recipe: recipe, service: mealAPIService)
        return RecipeDetailView(viewModel: vm)
    }
    
    func getFeaturedRecipeViewModel() {
        featuredRecipeViewModel = FeaturedRecipeViewModel(mealAPIService: mealAPIService)
    }
}
