//
//  RecipeHorizontalCellView.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/20/24.
//

import SwiftUI
import CachedAsyncImage

struct RecipeHorizontalCellView: View {
    
    let recipe: MealRecipe
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            CachedAsyncImage(url: recipe.imageURL) { imagePhase in
                switch imagePhase {
                case .empty:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                @unknown default:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .cornerRadius(12)
            
            
            Text(recipe.strMeal ?? "")
                .multilineTextAlignment(.center)
                .font(.system(size: 18, weight: .light , design: .rounded))
                .foregroundColor(.primary)
                .frame(maxHeight: 50)

        }
        .frame(width: 150, height: 200)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let meals = MealRecipe.DevData.getRandomRecipeCollection()
    
    return NavigationStack {
        ScrollView(.horizontal) {
            HStack {
                ForEach(meals) { meal in
                    NavigationLink(
                        destination: RecipeCellView(recipe: meal),
                        label: {
                            RecipeHorizontalCellView(recipe: meal)
                        })
                    
                }
            }
        }
    }
}
