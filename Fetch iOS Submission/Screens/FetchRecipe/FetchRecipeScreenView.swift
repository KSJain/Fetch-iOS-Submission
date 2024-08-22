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
            VStack(alignment: .leading) {
                
                FetchAppNavigationBarView()
                    .padding()
                
                Divider()
                    .background(.primary)
                    .padding(.bottom, 8)
                
                HStack {
                    Text("Featured Recipes")
                        .padding(.leading, 4)
                        .font(.system(size: 24, weight: .light))
                    
                    Button(action: {
                        viewModel.getFeaturedRecipes()
                    }, label: {
                        Image(systemName: "arrow.counterclockwise.circle")
                            .tint(.primary)
                    })
                }
                
                viewModel.getRecipeCollectionHorizontal()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.mealCatogries) { category in
                            HStack {
                                CachedAsyncImage(url: URL(string: category.strCategoryThumb ?? "")) { image in
                                    image
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .scaledToFit()
                                    
                                } placeholder: {
                                    Image(systemName: "fork.knife.circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .scaledToFit()
                                }

                                Text(category.strCategory ?? "Desserts")
                                    .font(.system(size: 18, 
                                                  weight: viewModel.selectedCategory == category ? .bold : .light))
                                    .lineLimit(1)
                                    .padding(.leading, 10)
                                    .scaledToFill()
                                    .onTapGesture {
                                        viewModel.setCategory(category: category)
                                    }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .background{
                                Capsule()
                                    .foregroundColor(.white.opacity(0.75))
                            }
                            .shadow(radius: 3)
                            
                        }
                    }
                }
                .scrollIndicators(.never)
                .padding(.bottom, 6)
                .padding(.horizontal, 6)
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(viewModel.catogorisedMeals) { recipe in
                        NavigationLink(
                            destination: viewModel.getDestinationViewFor(recipe: recipe),
                            label: {
                                RecipeTileCellView(recipe: recipe)
                                    .padding(.horizontal, 8)                            })
                    }
                }
            }

            .background(
                LinearGradient(
                    gradient: Gradient(colors:  [
                                            .green.opacity(0.3),
                                            .green.opacity(0.6),
                                            .green.opacity(0.9)
                                        ]),
                    startPoint: .top, 
                    endPoint: .bottom
                )
            )
        }
        .onAppear {
            viewModel.getFeaturedRecipes()
            viewModel.getCategories()
            viewModel.setCategory(category: MealCategory.DevData.mealCategory)
        }
    }
}

#Preview {
    let viewModel = FetchRecipeScreenViewModel(mealAPIService: MockMealAPIService())
    
    return FetchRecipeScreenView(viewModel: viewModel)
        .onAppear {
            viewModel.getCategories()
            viewModel.getMealForCategory("dessert")
            viewModel.getFeaturedRecipes()
        }
}
