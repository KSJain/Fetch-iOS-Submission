//
//  RecipeLookupScreenView.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/19/24.
//

import SwiftUI
import CachedAsyncImage

struct FetchRecipeScreenView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    FetchAppNavigationBarView()
                        .padding()

                    
                    Divider()
                        .background(.primary)
                        .padding(.bottom, 8)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.desserts) { meal in
                                NavigationLink(
                                    destination: Text(meal.strMeal ?? "oops"),
                                    label: {
                                        RecipeHorizontalCellView(recipe: meal)
                                    })
                                
                            }
                        }
                    }
                    .padding(.leading)
                }
                .navigationBarHidden(true)
            }
        }
        .onAppear {
            viewModel.getDesserts()
        }
    }
}

#Preview {
    let vm = DashboardViewModel(mealAPIService: MockMealAPIService())
    
    return FetchRecipeScreenView(viewModel: vm)
    .onAppear {
        vm.getDesserts()
    }
}
