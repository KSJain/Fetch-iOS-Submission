//
//  RecipeCollectionHorizontal.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/21/24.
//

import SwiftUI

final class RecipeCollectionHorizontalViewModel: ObservableObject {
    private let service: MealAPIServiceProtocol
    @Published var recipes: [MealRecipe]
    
    init(service: MealAPIServiceProtocol, recipes: [MealRecipe]) {
        self.service = service
        self.recipes = recipes
    }
    
    func getLabelFor(recipe: MealRecipe) -> RecipeHorizontalCellView {
        RecipeHorizontalCellView(recipe: recipe)
    }
    
    @MainActor 
    func getDestinationViewFor(recipe: MealRecipe) -> RecipeDetailView {
        let vm = RecipeDetailViewModel(recipe: recipe, service: service)
        return RecipeDetailView(viewModel: vm)
    }
}

struct RecipeCollectionHorizontal: View {
    
    @ObservedObject var viewModel: RecipeCollectionHorizontalViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.recipes) { meal in
                        NavigationLink(
                            destination: viewModel.getDestinationViewFor(recipe: meal),
                            label: {
                                viewModel.getLabelFor(recipe: meal)
                            })
                        
                    }
                }
            }
            .padding(.leading, 8)
        }
    }
}

#Preview (traits: .sizeThatFitsLayout) {
    RecipeCollectionHorizontal(viewModel: RecipeCollectionHorizontalViewModel(service: MockMealAPIService(), recipes: MealRecipe.DevData.getRecipeCollection()))
}
