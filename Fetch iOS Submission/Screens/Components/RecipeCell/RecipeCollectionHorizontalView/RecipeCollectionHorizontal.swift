//
//  RecipeCollectionHorizontal.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/21/24.
//

import SwiftUI

struct RecipeCollectionHorizontal: View {
    
    @ObservedObject var viewModel: RecipeCollectionHorizontalViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.recipes) { recipe in
                        NavigationLink(
                            destination: RecipeDetailView(viewModel: viewModel.getRecipeDetailViewModel(recipe: recipe)),
                            label: {
                                RecipeHorizontalCellView(recipe: recipe)
                            })
                        
                    }
                }
            }
            .padding(.leading, 8)
        }
    }
}

#Preview (traits: .sizeThatFitsLayout) {
    RecipeCollectionHorizontal(viewModel: RecipeCollectionHorizontalViewModel(mealAPIService: MockMealAPIService(), recipes: MealRecipe.DevData.getRecipeCollection()))
}
