//
//  RecipeLookupScreenView.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/19/24.
//

import SwiftUI
import CachedAsyncImage

struct FetchRecipeScreenView: View {
    @ObservedObject var viewModel: FetchRecipeScreenViewModel
    
    init(viewModel: FetchRecipeScreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                FetchAppNavigationBarView()
                    .padding()
                
                Divider()
                    .background(.primary)
                    .padding(.bottom, 8)
                
                FeaturedRecipeView(viewModel: viewModel.featuredRecipeViewModel)
                                
                CategorySelectorView(selectedCategory: $viewModel.selectedCategory, mealCatagories: $viewModel.mealCatogries)
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(viewModel.catogorisedMeals) { recipe in
                        NavigationLink(
                            destination: viewModel.getDestinationViewFor(recipe: recipe),
                            label: {
                                RecipeTileCellView(recipe: recipe)
                                    .padding(.horizontal, 8)                            })
                    }
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors:  [
                                            .green.opacity(0.3),
                                            .green.opacity(0.6),
                                            .green.opacity(0.9)
                                        ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .onAppear {
            viewModel.getCategories()
            viewModel.setCategory(category: MealCategory.DevData.mealCategory)
        }
    }
}

#Preview {
    let viewModel = FetchRecipeScreenViewModel(mealAPIService: MockMealAPIService())
    
    return FetchRecipeScreenView(viewModel: viewModel)
        .onAppear {
            viewModel.getCategories()
            viewModel.setCategory(category: MealCategory.DevData.mealCategory)
        }
}
