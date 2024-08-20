//
//  DashboardScreenView.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/19/24.
//

import SwiftUI

struct DashboardScreenView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("Category Selector")
                
                List {
                    ForEach(viewModel.desserts) { recipe in
                        NavigationLink {
                            Text(recipe.strMeal ?? "Meal Name")
                        } label: {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(recipe.id ?? "ID")
                                Text(recipe.strMeal ?? "Meal Name")
                                if let strMealThumb = recipe.strMealThumb,
                                   let url = URL(string: strMealThumb)
                                {
                                    AsyncImage(url: url, scale: 30)
                                }
                                
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Recipes")
        .onAppear {
            viewModel.getDesserts()
        }
    }
}

#Preview {
    NavigationStack {
        DashboardScreenView(viewModel: DashboardViewModel(mealAPIService: MockMealAPIService()))

    }
}
