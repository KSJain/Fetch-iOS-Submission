//
//  FeaturedRecipeView.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/22/24.
//

import SwiftUI

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

struct FeaturedRecipeView: View {
    @ObservedObject var viewModel: FeaturedRecipeViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Featured Recipes")
                    .padding(.leading, 4)
                    .font(.system(size: 24, weight: .light))
                
                Button(action: {
                    viewModel.getFeaturedRecipes()
                }, label: {
                    Image(systemName: "arrow.counterclockwise.circle")
                        .tint(.primary)
                })
            }
            
            if let recipeViewModel = viewModel.recipeViewModel {
                RecipeCollectionHorizontal(viewModel: recipeViewModel)
            }
        }
    }
}

#Preview {
    let viewModel = FeaturedRecipeViewModel(mealAPIService: MockMealAPIService())
    return FeaturedRecipeView(viewModel: viewModel)
}
