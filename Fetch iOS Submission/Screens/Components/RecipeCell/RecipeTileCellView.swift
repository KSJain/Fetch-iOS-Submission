//
//  RecipeCellView.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/20/24.
//

import SwiftUI
import CachedAsyncImage

@MainActor
final class RecipeTileCellViewModel: ObservableObject {
    let mealServiceAPI: MealAPIServiceProtocol
    @Published var recipe: MealRecipe
    @Published var areaText: String = ""
    
    init(recipe: MealRecipe, mealServiceAPI: MealAPIServiceProtocol) {
        self.mealServiceAPI = mealServiceAPI
        self.recipe = recipe
        
        getDetailedRecipe()
    }
    
    func getDetailedRecipe(id: String = "") {
        
        var recipeId = ""
        if !id.isEmpty {
            recipeId = id
        } else if let id = recipe.id {
            recipeId = id
        }
        
        Task {
            if let meals = try await mealServiceAPI.getMealBy(id: recipeId).meals.first {
                recipe = meals
                
                if let area = meals.strArea {
                    areaText = area
                }
            }
        }
        
    }
}

struct RecipeTileCellView: View {
    @ObservedObject var viewModel: RecipeTileCellViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            
            CachedAsyncImage(url: viewModel.recipe.recipeThumbURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .shadow(radius: 3)
                    .cornerRadius(20)
                
            } placeholder: {
                ProgressView()
                    .frame(height: 200)
            }
            .padding(7)
            .frame(width: 200)
            
            VStack(alignment: .leading) {
                Text(viewModel.recipe.strMeal ?? "")
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .font(.system(size: 28, weight: .medium, design: .monospaced))
                    .minimumScaleFactor(0.7)

                Spacer()

                VStack(alignment: .trailing) {
                    Text(viewModel.areaText)
                }
                .padding(.bottom)
            }
            .padding(.vertical)
            .padding(.horizontal, 6)
            
            Spacer()
        }
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.6))
        .cornerRadius(20)
        .tint(.primary)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let viewModel = RecipeTileCellViewModel(
        recipe: MealRecipe.DevData.demoRecipe,
        mealServiceAPI: MockMealAPIService()
    )
    
    return RecipeTileCellView(viewModel: viewModel)
}

#Preview(traits: .sizeThatFitsLayout) {
    let viewModel = RecipeTileCellViewModel(
        recipe: MealRecipe.DevData.demoRecipeBadURL,
        mealServiceAPI: MockMealAPIService()
    )
    
    return RecipeTileCellView(viewModel: viewModel)
}
