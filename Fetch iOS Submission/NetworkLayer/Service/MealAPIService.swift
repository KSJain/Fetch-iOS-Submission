//
//  MealAPIService.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/18/24.
//

import Foundation

protocol MealAPIServiceProtocol {
    func getMealsByCategory(_ category: String) async throws  -> MealResponse
    func getMealsByArea(_ area: String) async throws  -> MealResponse
    func getMealsByMainIngredient(_ ingredient: String) async throws  -> MealResponse
    func getMealsByFirstLetter(_ firstLetter: String) async throws  -> MealResponse
    func getMealsByName(_ name: String) async throws  -> MealResponse

    func getMealBy(id: String) async throws  -> MealResponse
    func getRandomMeal() async throws  -> MealResponse

    func listAllAreas() async throws  -> MealResponse
    func listAllCategories() async throws  -> MealCategoryResponse
    func listAllIngredients() async throws  -> MealIngredientsResponse
}

final class MealAPIService: MealAPIServiceProtocol {
        
    func getMealsByCategory(_ category: String) async throws  -> MealResponse {
        try await MealDataAPI
            .filterByCategory(category: category)
            .requestData(MealResponse.self, print: false)
    }
    
    func getMealsByArea(_ area: String) async throws -> MealResponse {
        try await MealDataAPI
            .filterByArea(area: area)
            .requestData(MealResponse.self, print: false)
    }
    
    func getMealsByMainIngredient(_ ingredient: String) async throws -> MealResponse {
        try await MealDataAPI
            .filterByMainIngredient(ingredient: ingredient)
            .requestData(MealResponse.self, print: false)
    }
    
    func getMealsByFirstLetter(_ firstLetter: String) async throws -> MealResponse {
        try await MealDataAPI
            .searchByFirstLetter(firstLetter: firstLetter)
            .requestData(MealResponse.self, print: false)
    }
    
    func getMealsByName(_ name: String) async throws -> MealResponse {
        try await MealDataAPI
            .searchByName(name: name)
            .requestData(MealResponse.self, print: false)
    }
    
    func getMealBy(id: String) async throws -> MealResponse {
        try await MealDataAPI
            .lookupById(id: id)
            .requestData(MealResponse.self, print: false)
    }
    
    func getRandomMeal() async throws -> MealResponse {
        try await MealDataAPI
            .random
            .requestData(MealResponse.self, print: false)
    }
    
    func listAllAreas() async throws -> MealResponse {
        try await MealDataAPI
            .listAllAreas
            .requestData(MealResponse.self, print: false)
    }
    
    func listAllCategories() async throws -> MealCategoryResponse {
        try await MealDataAPI
            .listAllCategories
            .requestData(MealCategoryResponse.self, print: false)
    }
    
    func listAllIngredients() async throws -> MealIngredientsResponse {
        try await MealDataAPI
            .listAllIngredients
            .requestData(MealIngredientsResponse.self, print: false)
    }
}

final class MockMealAPIService: MealAPIServiceProtocol {
    func getMealsByCategory(_ category: String) async throws -> MealResponse {
        MealResponse(meals: MealRecipe.DevData.getRecipeCollection())
    }
    
    func getMealsByArea(_ area: String) async throws -> MealResponse {
        MealResponse(meals: [])
    }
    
    func getMealsByMainIngredient(_ ingredient: String) async throws -> MealResponse {
        MealResponse(meals: [])
    }
    
    func getMealsByFirstLetter(_ firstLetter: String) async throws -> MealResponse {
        MealResponse(meals: [])
    }
    
    func getMealsByName(_ name: String) async throws -> MealResponse {
        MealResponse(meals: [])
    }
    
    func getMealBy(id: String) async throws -> MealResponse {
        MealResponse(meals: [])
    }
    
    func getRandomMeal() async throws -> MealResponse {
        MealResponse(meals: [])
    }
    
    func listAllAreas() async throws -> MealResponse {
        MealResponse(meals: [])
    }
    
    func listAllCategories() async throws -> MealCategoryResponse {
        MealCategoryResponse(categories: [])
    }
    
    func listAllIngredients() async throws -> MealIngredientsResponse {
        MealIngredientsResponse(meals: [])
    }
    
    
}
