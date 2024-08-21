//
//  RecipeCellView.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/20/24.
//

import SwiftUI

struct RecipeCellView: View {
    let recipe: MealRecipe
    
    var body: some View {
        Text(recipe.strMeal ?? "Hello, World!")
            .navigationBarHidden(true)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RecipeCellView(recipe: MealRecipe.DevData.demoRecipe)
}
