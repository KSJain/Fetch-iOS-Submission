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
            
            let url = URL(string: recipe?.strMealThumb ?? "url")
            CachedAsyncImage(url: url) { imagePhase in
                switch imagePhase {
                case .empty:
                    Image(systemName: "fork.knife")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                case .failure:
                    Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                @unknown default:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 200)
            .cornerRadius(20)
            .padding(7)
            .shadow(radius: 10)
            
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
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.6))
        .cornerRadius(20)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    
    RecipeTileCellView(recipe: MealRecipe.DevData.demoRecipe)
}
