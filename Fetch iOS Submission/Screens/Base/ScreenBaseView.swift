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
        DashboardScreenView(viewModel: viewModel.getDashboardViewModel())
    }
}

#Preview {
    let mealAPIService = MockMealAPIService()
    let viewModel = ViewModelFactory(mealAPIService: mealAPIService)
    return ScreenBaseView(viewModel: viewModel)
}
