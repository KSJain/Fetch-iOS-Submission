//
//  RecipeDetailViewModel.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/22/24.
//

import Foundation

@MainActor
final class RecipeDetailViewModel: ObservableObject {
    @Published var recipe: MealRecipe
    private let service: any MealAPIServiceProtocol
    
    init(recipe: MealRecipe, service: any MealAPIServiceProtocol) {
        self.service = service
        self.recipe = recipe
    }
    
    func getRecipeDetails() {
        Task {[weak self] in
            if let id = self?.recipe.id,
               let recipe = try await self?.service.getMealBy(id: id).meals.first {
                self?.recipe = recipe
            }
        }
    }
}
