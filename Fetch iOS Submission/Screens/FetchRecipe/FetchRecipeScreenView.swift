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
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    
                    FetchAppNavigationBarView()
                        .padding()

                    
                    Divider()
                        .background(.primary)
                        .padding(.bottom, 8)
                    
                    RecipeCollectionHorizontal(recipes: viewModel.desserts)
                }
            }
        }
        .onAppear {
            viewModel.getDesserts()
        }
    }
}

#Preview {
    let vm = FetchRecipeScreenViewModel(mealAPIService: MockMealAPIService())
    
    return FetchRecipeScreenView(viewModel: vm)
    .onAppear {
        vm.getDesserts()
    }
}

struct RecipeCollectionHorizontal: View {
    
    let recipes: [MealRecipe]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Desserts")
                .padding(.leading, 10)
                .font(.system(size: 24, weight: .ultraLight))
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(recipes) { meal in
                        NavigationLink(
                            destination: RecipeDetailView(recipe: meal),
                            label: {
                                RecipeHorizontalCellView(recipe: meal)
                            })
                        
                    }
                }
            }
            .padding(.leading)
        }
    }
}
