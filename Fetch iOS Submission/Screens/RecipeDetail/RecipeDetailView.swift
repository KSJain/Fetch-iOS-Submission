//
//  RecipeDetail.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/20/24.
//

import SwiftUI
import CachedAsyncImage

struct RecipeDetailView: View {
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var viewModel: RecipeDetailViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                
                ZStack {
                    VStack {
                        HStack {
                            Button(action: { dismiss() }, label: {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(.primary)
                            })
                            
                            Spacer()
                        }
                        .padding()
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 2) {
                        Text(viewModel.recipe.strMeal ?? "")
                            .font(.system(size: 28, weight: .light))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .lineLimit(2)
                            .scaledToFit()
                        
                        if let area = viewModel.recipe.strArea {
                            Text(area)
                                .font(.system(size: 18, weight: .light))
                                .lineLimit(2)
                                .padding(.bottom)
                                .scaledToFit()
                        }
                    }
                }
                
                CachedAsyncImage(url: viewModel.recipe.imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                        .cornerRadius(30)
                    
                } placeholder: {
                    ProgressView()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                        .frame(width: 300)
                        .border(Color.black)
                }
                .padding()

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Ingredients")
                            .font(.system(.title, design: .serif, weight: .medium))
                        
                        Spacer()
                        
                        if let youTubeURL = viewModel.recipe.youTubeURL {
                            Link(destination: youTubeURL) {
                                Image(systemName: "play.circle")
                                    .font(.largeTitle)
                            }
                        }
                    }
                    .padding(.vertical, 6)

                    Text(viewModel.recipe.strInstructions ?? "")
                }
                .padding(.horizontal)
                
                if !viewModel.recipe.ingredients.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.system(.title, design: .serif, weight: .medium))
                        
                        ForEach(0..<viewModel.recipe.ingredients.count) { index in
                            let opacity = (index % 2 == 0) ? 0.1 : 0.0
                            let ingredient = viewModel.recipe.ingredients[index]
                            HStack {
                                Text(ingredient.name)
                                Spacer()
                                Text(ingredient.measure)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(opacity))
                        }
                    }
                    .padding()
                }

            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.getRecipeDetails()
        }
    }
}

#Preview {
    RecipeDetailView(viewModel: RecipeDetailViewModel(
        recipe: MealRecipe.DevData.demoRecipe,
        service: MockMealAPIService()))
}
