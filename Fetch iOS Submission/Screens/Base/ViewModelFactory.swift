//
//  ViewModelFactory.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/19/24.
//

import Foundation

@MainActor
class ViewModelFactory: ObservableObject {
    
    let mealAPIService: any MealAPIServiceProtocol
    
    init(mealAPIService: any MealAPIServiceProtocol) {
        self.mealAPIService = mealAPIService
    }
    
    func getDashboardViewModel() -> FetchRecipeScreenViewModel {
        FetchRecipeScreenViewModel(mealAPIService: mealAPIService)
    }
}
