//
//  MealAPIService.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/18/24.
//

import Foundation

protocol MealAPIServiceProtocol {
    func getMeals(category: String)
    func getMealBy(id: String)
}
