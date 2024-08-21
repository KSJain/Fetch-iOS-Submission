//
//  RecipeDetail.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/20/24.
//

import SwiftUI

struct RecipeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let recipe: MealRecipe
    
    var body: some View {
        VStack {
            Text(recipe.strMeal ?? "")
                .font(.system(size: 24, weight: .ultraLight))
                .padding(.leading, 8)
                .onTapGesture {
                    dismiss()
                }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    RecipeDetailView(recipe: MealRecipe.DevData.demoRecipe)
}
