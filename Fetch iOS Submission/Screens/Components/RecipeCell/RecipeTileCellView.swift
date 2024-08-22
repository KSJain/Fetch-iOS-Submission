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
        HStack(alignment: .top, spacing: 0) {
            
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
            
            VStack(alignment: .leading) {
                Text(recipe?.strMeal ?? "strMeal")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 18, weight: .medium, design: .monospaced))
                
                Spacer()
                
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(recipe?.strCategory ?? "strCategory")
                        .fontWeight(.bold)
                    HStack {
                        Image(systemName: "location.square")
                        Text(recipe?.strArea ?? "strArea")
                    }
                    
                    if !(recipe?.strTags.isEmpty == false) {
                        HStack {
                            Image(systemName: "tag.square")
                            Text(recipe?.strTags.joined(separator: " ") ?? "")
                        }
                    }
                }
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
