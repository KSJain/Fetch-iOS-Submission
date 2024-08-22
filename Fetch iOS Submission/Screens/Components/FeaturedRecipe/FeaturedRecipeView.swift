//
//  FeaturedRecipeView.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/22/24.
//

import SwiftUI

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
                    if viewModel.recipes.isEmpty {
                        ProgressView()
                            .padding(.leading, 5)
                    } else {
                        Image(systemName: "arrow.counterclockwise.circle")
                            .tint(.primary)
                    }
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
