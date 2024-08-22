//
//  MealDBModels.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/18/24.
//

import Foundation

struct MealCategoryResponse: Codable {
    let categories: [MealCategory]
}

struct MealCategory: Codable, Identifiable, Equatable  {
    let id: String?
    let strCategory: String?
    let strCategoryThumb: String?
    let strCategoryDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case strCategory
        case strCategoryThumb
        case strCategoryDescription
    }
    
    static func == (lhs: MealCategory, rhs: MealCategory) -> Bool {
        lhs.id == rhs.id
    }
}

struct MealIngredientsResponse: Codable {
    let meals: [MealIngredient]
}

struct MealIngredient: Codable, Identifiable {
    let id: String?
    let strIngredient: String?
    let strDescription: String?
    let strType: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idIngredient"
        case strIngredient
        case strDescription
        case strType
    }
}

struct MealResponse: Decodable, Equatable {
    let meals: [MealRecipe]
    let caregory: String?
    let area: String?
    
    init(
        meals: [MealRecipe],
        caregory: String? = nil,
        area: String? = nil
    ) {
        self.meals = meals
        self.caregory = caregory
        self.area = area
    }
}

struct RecipeIngredient: Codable, Identifiable {
    let id = UUID().uuidString
    let name: String
    let measure: String
}

struct MealRecipe: Identifiable {
    let id: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: [String]
    let strYoutube: String?
    
    let ingredients: [RecipeIngredient]
    
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    init(
        id: String?,
        strMeal: String?,
        strDrinkAlternate: String? = nil,
        strCategory: String? = nil,
        strArea: String? = nil,
        strInstructions: String? = nil,
        strMealThumb: String?,
        strTags: [String] = [],
        strYoutube: String? = nil,
        ingredients: [RecipeIngredient] = [],
        strSource: String? = nil,
        strImageSource: String? = nil,
        strCreativeCommonsConfirmed: String? = nil,
        dateModified: String? = nil
    ) {
        self.id = id
        self.strMeal = strMeal
        self.strDrinkAlternate = strDrinkAlternate
        self.strCategory = strCategory
        self.strArea = strArea
        self.strInstructions = strInstructions
        self.strMealThumb = strMealThumb
        self.strTags = strTags
        self.strYoutube = strYoutube
        self.ingredients = ingredients
        self.strSource = strSource
        self.strImageSource = strImageSource
        self.strCreativeCommonsConfirmed = strCreativeCommonsConfirmed
        self.dateModified = dateModified
    }
}

extension MealRecipe: Equatable {
    static func == (lhs: MealRecipe, rhs: MealRecipe) -> Bool {
        lhs.id == rhs.id
    }
}

extension MealRecipe: Codable {
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        init(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMeal
        case strDrinkAlternate
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
        case strTags
        case strYoutube
        case ingredients
        case strSource
        case strImageSource
        case strCreativeCommonsConfirmed
        case dateModified
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.id.stringValue))
        strMeal = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.strMeal.stringValue))
        strDrinkAlternate = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.strDrinkAlternate.stringValue))
        strCategory = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.strCategory.stringValue))
        strArea = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.strArea.stringValue))
        strInstructions = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.strInstructions.stringValue))
        strMealThumb = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.strMealThumb.stringValue))
        let tagStr = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.strTags.stringValue))
        strTags = tagStr?.components(separatedBy: ",") ?? []
        strYoutube = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.strYoutube.stringValue))
        
        strSource = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.strSource.stringValue))
        strImageSource = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.strImageSource.stringValue))
        strCreativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.strCreativeCommonsConfirmed.stringValue))
        dateModified = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.dateModified.stringValue))
        
        var ingredientz: [RecipeIngredient] = []
        
        for i in 1...20 {
            let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)")
            guard let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey), !ingredient.isEmpty
            else { break }
            
            let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(i)")
            guard let measure = try container.decodeIfPresent(String.self, forKey: measureKey),!measure.isEmpty
            else { break }
            
            ingredientz.append(.init(name: ingredient, measure: measure))
        }
        
        ingredients = ingredientz
    }
}

extension MealRecipe {
    var imageURL: URL? {
        guard let strMealThumb else { return nil }
        return URL(string: strMealThumb)
    }
    
    var recipeThumbURL: URL? {
        guard let strMealThumb else { return nil }
        return URL(string: strMealThumb)
    }
    
    var youTubeURL: URL? {
        guard let strYoutube else { return nil }
        return URL(string: strYoutube)
    }
}

// Preview Dev Data
extension MealCategory {
    struct DevData {
        static let mealCategory = MealCategory(
            id: "3",
            strCategory: "Dessert",
            strCategoryThumb: "https://www.themealdb.com/images/category/dessert.png",
            strCategoryDescription: "Dessert is a course that concludes a meal. The course usually consists of sweet foods, such as confections dishes or fruit, and possibly a beverage such as dessert wine or liqueur, however in the United States it may include coffee, cheeses, nuts, or other savory items regarded as a separate course elsewhere. In some parts of the world, such as much of central and western Africa, and most parts of China, there is no tradition of a dessert course to conclude a meal.\r\n\r\nThe term dessert can apply to many confections, such as biscuits, cakes, cookies, custards, gelatins, ice creams, pastries, pies, puddings, and sweet soups, and tarts. Fruit is also commonly found in dessert courses because of its naturally occurring sweetness. Some cultures sweeten foods that are more commonly savory to create desserts."
        )
        
        static let mealCategoryCollection: [MealCategory] = [
            mealCategory,
            .init(id: "13", strCategory: "Breakfast", strCategoryThumb: "https://www.themealdb.com/images/category/breakfast.png", strCategoryDescription: nil),
            .init(id: "11", strCategory: "Vegan", strCategoryThumb: "https://www.themealdb.com/images/category/vegan.png", strCategoryDescription: nil),
        ]
    }
}

extension RecipeIngredient {
    struct DevData {
        static let ingredientDemo = RecipeIngredient(name: "soy sauce", measure: "3/4 cup")
        
        static let ingredientCollection: [RecipeIngredient] = [
            .init(name: "soy sauce", measure: "3/4 cup"),
            .init(name: "water", measure: "3/4 cup"),
            .init(name: "brown sugar", measure: "3/4 cup"),
            .init(name: "ground ginger", measure: "3/4 cup"),
            .init(name: "minced garlic", measure: "3/4 cup"),
            .init(name: "cornstarch", measure: "3/4 cup"),
            .init(name: "chicken breasts", measure: "3/4 cup"),
            .init(name: "stir-fry vegetables", measure: "3/4 cup"),
            .init(name: "brown rice", measure: "3/4 cup"),
        ]
    }
}
extension MealRecipe {
    struct DevData {
        
        static func getRecipeCollection() -> [MealRecipe] {
            [
                .init(id: "52970", strMeal: "Tunisian Orange Cake", strMealThumb: "https://www.themealdb.com/images/media/meals/y4jpgq1560459207.jpg"),
                .init(id: "52793", strMeal: "Sticky Toffee Pudding Ultimate", strMealThumb: "https://www.themealdb.com/images/media/meals/xrptpq1483909204.jpg"),
                .init(id: "52854", strMeal: "Pancakes", strMealThumb: "https://www.themealdb.com/images/media/meals/rwuyqx1511383174.jpg"),
                .init(id: "52988", strMeal: "Classic Christmas pudding", strMealThumb: "https://www.themealdb.com/images/media/meals/1d85821576790598.jpg"),
                .init(id: "52898", strMeal: "Chelsea Buns", strMealThumb: "https://www.themealdb.com/images/media/meals/vqpwrv1511723001.jpg"),
                .init(id: "52791", strMeal:  "Eton Mess", strMealThumb: "https://www.themealdb.com/images/media/meals/uuxwvq1483907861.jpg")
            ]
        }
        
        
        static let demoRecipe = MealRecipe(
            id: "52772",
            strMeal: "Teriyaki Chicken Casserole",
            strDrinkAlternate: nil, 
            strCategory: "Chicken",
            strArea: "Japanese",
            strInstructions: "Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\nMeanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.\r\nPlace the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.\r\n*Meanwhile, steam or cook the vegetables according to package directions.\r\nAdd the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!",
            strMealThumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
            strTags: ["Meat", "Casserole"],
            strYoutube: "https://www.youtube.com/watch?v=4aZr5hZXP_s",
            ingredients: RecipeIngredient.DevData.ingredientCollection,
            strSource: nil,
            strImageSource: nil,
            strCreativeCommonsConfirmed: nil,
            dateModified: nil
        )
        
        static let demoRecipeBadURL = MealRecipe(
            id: "52772",
            strMeal: "Teriyaki Chicken Casserole",
            strDrinkAlternate: nil,
            strCategory: "Chicken",
            strArea: "Japanese",
            strInstructions: "Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\nMeanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.\r\nPlace the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.\r\n*Meanwhile, steam or cook the vegetables according to package directions.\r\nAdd the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!",
            strMealThumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg_BAD",
            strTags: ["Meat", "Casserole"],
            strYoutube: "https://www.youtube.com/watch?v=4aZr5hZXP_s",
            ingredients: RecipeIngredient.DevData.ingredientCollection,
            strSource: nil,
            strImageSource: nil,
            strCreativeCommonsConfirmed: nil,
            dateModified: nil
        )
    }
}
