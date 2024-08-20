//
//  ScreenBaseView.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/19/24.
//

import SwiftUI

struct ScreenBaseView: View {
    @ObservedObject var viewModel: ViewModelFactory
    
    var body: some View {
        TabView {
            NavigationStack {
                Text("Look Up Recipe")
            }
            .tag("look_up_screen")
            .tabItem {
                Label("Lookup", systemImage: "magnifyingglass")
            }
            
            FetchRecipeScreenView(viewModel: viewModel.getDashboardViewModel())
            .tag("fetch_screen")
            .tabItem {
                Label("Fetch", systemImage: "dog")
            }
            
            NavigationStack {
                Text("User Profile")
            }
            .tag("favorites_screen")
            .tabItem {
                Label("Favorites", systemImage: "star")
            }
        }
    }
}

#Preview {
    let mealAPIService = MockMealAPIService()
    let viewModel = ViewModelFactory(mealAPIService: mealAPIService)
    return ScreenBaseView(viewModel: viewModel)
}
