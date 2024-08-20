//
//  MealDataAPI.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/18/24.
//

import Foundation

import SwiftUI

enum MealDataAPI: Api {
    
    case searchByFirstLetter(firstLetter: String)
    case searchByName(name: String)
    
    case lookupById(id: String)
    case random
    
    case listAllCategories
    case listAllAreas
    case listAllIngredients
    
    case filterByCategory(category: String)
    case filterByArea(area: String)
    case filterByMainIngredient(ingredient: String)
    
    case ingredientImage(name: String)
    
    var method: HttpMethod { .GET }
    
    var baseUrl: BaseUrl { .themealdb }

    var path: String {
        switch self {
        case .searchByName, .searchByFirstLetter:
            return "/api/json/v1/1/search.php"
            
        case .lookupById:
            return "/api/json/v1/1/lookup.php"
            
        case .listAllCategories:
            return "/api/json/v1/1/categories.php"
            
        case .random:
            return "/api/json/v1/1/random.php"
            
        case .listAllAreas, .listAllIngredients:
            return "/api/json/v1/1/list.php"
            
        case .filterByCategory, .filterByMainIngredient, .filterByArea:
            return "/api/json/v1/1/filter.php"
            
        case .ingredientImage(name: let name):
            return "/images/ingredients/\(name.urlFormatted()).png"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchByName(name: let nameStr):
            return [ URLQueryItem(name: "s", value: nameStr) ]
            
        case .searchByFirstLetter(firstLetter: let firstLetter):
            return [ URLQueryItem(name: "f", value: firstLetter)]
            
        case .lookupById(let id):
            return [ URLQueryItem(name: "i", value: String(id)) ]
            
        case .random, .listAllCategories, .ingredientImage:
            return []
            
        case .listAllAreas:
            return [ URLQueryItem(name: "a", value: "list") ]
            
        case .listAllIngredients:
            return [ URLQueryItem(name: "i", value: "list") ]
            
        case .filterByCategory(category: let category):
            return [ URLQueryItem(name: "c", value: category) ]
            
        case .filterByArea(area: let area):
            return [  URLQueryItem(name: "a", value: area) ]
            
        case .filterByMainIngredient(ingredient: let ingredient):
            return [  URLQueryItem(name: "i", value: ingredient) ]
        }
    }

    var body: Data? { nil }

}
