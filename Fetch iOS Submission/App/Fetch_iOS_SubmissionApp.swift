//
//  Fetch_iOS_SubmissionApp.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/18/24.
//

import SwiftUI

@main
struct Fetch_iOS_SubmissionApp: App {
    let mealService = MealAPIService()
    var body: some Scene {
        WindowGroup {
            let viewModel = ViewModelFactory(mealAPIService: mealService)
            ScreenBaseView(viewModel: viewModel)
        }
    }
}
