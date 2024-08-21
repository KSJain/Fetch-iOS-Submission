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

struct MealCategory: Codable, Identifiable  {
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

struct RecipeIngredient: Codable {
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
    let strTags: String?
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
        strTags: String? = nil,
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
        strTags = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: CodingKeys.strTags.stringValue))
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
}

// Preview Dev Data
extension MealRecipe {
    struct DevData {
        
        static func getMealRecipeId52772() -> MealRecipe? {
            let data = jsonDataMealId52772.data(using: .utf8)!
            return try? JSONDecoder().decode(MealRecipe.self, from: data)
        }
        
        static func getRandomRecipeCollection() -> [MealRecipe] {
            [
                .init(id: "52970", strMeal: "Tunisian Orange Cake", strMealThumb: "https://www.themealdb.com/images/media/meals/y4jpgq1560459207.jpg"),
                .init(id: "52793", strMeal: "Sticky Toffee Pudding Ultimate", strMealThumb: "https://www.themealdb.com/images/media/meals/xrptpq1483909204.jpg"),
                .init(id: "52854", strMeal: "Pancakes", strMealThumb: "https://www.themealdb.com/images/media/meals/rwuyqx1511383174.jpg"),
                .init(id: "52988", strMeal: "Classic Christmas pudding", strMealThumb: "https://www.themealdb.com/images/media/meals/1d85821576790598.jpg"),
                .init(id: "52898", strMeal: "Chelsea Buns", strMealThumb: "https://www.themealdb.com/images/media/meals/vqpwrv1511723001.jpg"),
                .init(id: "52791", strMeal:  "Eton Mess", strMealThumb: "https://www.themealdb.com/images/media/meals/uuxwvq1483907861.jpg")
            ]
        }
        
        
        static let demoRecipe = MealRecipe(id: "52772", strMeal: "Teriyaki Chicken Casserole", strDrinkAlternate: nil, strCategory: nil, strArea: nil, strInstructions: nil, strMealThumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg", strTags: nil, strYoutube: nil, ingredients: [], strSource: nil, strImageSource: nil, strCreativeCommonsConfirmed: nil, dateModified: nil)
        
        static let jsonDataMealId52772 =
        """
              {
                "idMeal": "52772",
                "strMeal": "Teriyaki Chicken Casserole",
                "strDrinkAlternate": null,
                "strCategory": "Chicken",
                "strArea": "Japanese",
                "strInstructions": "Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\nMeanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.\r\nPlace the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.\r\n*Meanwhile, steam or cook the vegetables according to package directions.\r\nAdd the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!",
                "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
                "strTags": "Meat,Casserole",
                "strYoutube": "https://www.youtube.com/watch?v=4aZr5hZXP_s",
                "strIngredient1": "soy sauce",
                "strIngredient2": "water",
                "strIngredient3": "brown sugar",
                "strIngredient4": "ground ginger",
                "strIngredient5": "minced garlic",
                "strIngredient6": "cornstarch",
                "strIngredient7": "chicken breasts",
                "strIngredient8": "stir-fry vegetables",
                "strIngredient9": "brown rice",
                "strIngredient10": "",
                "strIngredient11": "",
                "strIngredient12": "",
                "strIngredient13": "",
                "strIngredient14": "",
                "strIngredient15": "",
                "strIngredient16": null,
                "strIngredient17": null,
                "strIngredient18": null,
                "strIngredient19": null,
                "strIngredient20": null,
                "strMeasure1": "3/4 cup",
                "strMeasure2": "1/2 cup",
                "strMeasure3": "1/4 cup",
                "strMeasure4": "1/2 teaspoon",
                "strMeasure5": "1/2 teaspoon",
                "strMeasure6": "4 Tablespoons",
                "strMeasure7": "2",
                "strMeasure8": "1 (12 oz.)",
                "strMeasure9": "3 cups",
                "strMeasure10": "",
                "strMeasure11": "",
                "strMeasure12": "",
                "strMeasure13": "",
                "strMeasure14": "",
                "strMeasure15": "",
                "strMeasure16": null,
                "strMeasure17": null,
                "strMeasure18": null,
                "strMeasure19": null,
                "strMeasure20": null,
                "strSource": null,
                "strImageSource": null,
                "strCreativeCommonsConfirmed": null,
                "dateModified": null
              }
        """
    }
}
