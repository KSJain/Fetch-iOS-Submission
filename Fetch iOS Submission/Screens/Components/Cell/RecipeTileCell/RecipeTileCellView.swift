//
//  RecipeCellView.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/20/24.
//

import SwiftUI
import CachedAsyncImage

struct RecipeTileCellView: View {
    let recipe: MealRecipe?
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
            CachedAsyncImage(url: recipe?.recipeThumbURL) { image in
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
            
            VStack(alignment: .center) {
                Text(recipe?.strMeal ?? "")
                    .multilineTextAlignment(.leading)
                    .lineLimit(4)
                    .font(.system(size: 21, weight: .medium, design: .monospaced))
                    .minimumScaleFactor(0.7)
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
    RecipeTileCellView(recipe: MealRecipe.DevData.demoRecipe)
}

#Preview(traits: .sizeThatFitsLayout) {
    RecipeTileCellView(recipe: MealRecipe.DevData.demoRecipeBadURL)
}
