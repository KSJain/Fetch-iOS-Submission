//
//  FetchRecipeScreenViewModelTests.swift
//  Fetch iOS SubmissionTests
//
//  Created by Kartikeya Saxena Jain on 8/22/24.
//

import XCTest

final class FetchRecipeScreenViewModelTests: XCTestCase {
    @MainActor func test_initializeWithMockService() throws {
        // GIVEN
        let mockService = MockMealAPIService()

        // WHEN
        let vm = FetchRecipeScreenViewModel(mealAPIService: mockService)

        // THEN
        XCTAssertEqual(vm.catogorisedMeals, [])
        XCTAssertEqual(vm.featuredRecipes, [])
        XCTAssertEqual(vm.mealCatogries, [])
        XCTAssertEqual(vm.selectedCategory, MealCategory.DevData.mealCategory)
    }

    @MainActor func test_getCategories_sets_mealCatagories() async {
        // GIVEN
        let mockService = MockMealAPIService()
        let vm = FetchRecipeScreenViewModel(mealAPIService: mockService)
        vm.selectedCategory = MealCategory.DevData.breakfast

        // WHEN
        let expectation = expectation(description: #function)
        mockService.didLoadCatagories = { expectation.fulfill() }

        vm.getCategories()
        await fulfillment(of: [expectation], timeout: 1)

        // THEN
        XCTAssertEqual(vm.selectedCategory, MealCategory.DevData.breakfast)
        XCTAssertEqual(vm.mealCatogries, MealCategory.DevData.mealCategoryCollection.reversed())
    }

    @MainActor func test_getMealForCategory_invalidCatagory_setsMealCatagories() async {
        // GIVEN
        let mockService = MockMealAPIService()
        let vm = FetchRecipeScreenViewModel(mealAPIService: mockService)
        let collection = MealRecipe.DevData.getRecipeCollection()
        vm.catogorisedMeals = collection


        // WHEN
        let expectation = expectation(description: #function)
        mockService.didGetMealsByCategory = { expectation.fulfill() }

        let badCatagory = MealCategory.DevData.badCatagory
        vm.getMealForCategory(badCatagory)
        await fulfillment(of: [expectation], timeout: 3)

        // THEN
        XCTAssertEqual(vm.selectedCategory, MealCategory.DevData.mealCategory)
        XCTAssertNotEqual(vm.catogorisedMeals, collection)
    }

    @MainActor func test_getMealForCatagory_validValidCatagory_setsMealCatagories() async {
        // GIVEN
        let mockService = MockMealAPIService()
        let vm = FetchRecipeScreenViewModel(mealAPIService: mockService)
        let catagory = MealCategory.DevData.testCatagory

        // WHEN
        let expectation = expectation(description: #function)
        mockService.didGetMealsByCategory = { expectation.fulfill() }

        vm.getMealForCategory(catagory)
        await fulfillment(of: [expectation], timeout: 1)

        // THEN
        XCTAssertEqual(vm.catogorisedMeals, MealRecipe.DevData.getRecipeCollectionForTestCatagory())
    }

    @MainActor func test_setCategory_validCategory_setsMealCatagories() async {
        // GIVEN
        let mockService = MockMealAPIService()
        let vm = FetchRecipeScreenViewModel(mealAPIService: mockService)
        let newCategory = MealCategory.DevData.vegan
        let collection = MealCategory.DevData.mealCategoryCollection

        // WHEN
        vm.mealCatogries = collection
        vm.setCategory(category: newCategory)

        // THEN
        XCTAssertEqual(vm.selectedCategory, newCategory)
        XCTAssertEqual(vm.mealCatogries, collection)

    }

    @MainActor func test_setCategory_invalidCategory_setsMealCatagories() async {
        // GIVEN
        let mockService = MockMealAPIService()
        let vm = FetchRecipeScreenViewModel(mealAPIService: mockService)
        let newCategory = MealCategory.DevData.badCatagory
        let collection = MealCategory.DevData.mealCategoryCollection

        // WHEN
        vm.mealCatogries = collection
        vm.setCategory(category: newCategory)

        // THEN
        XCTAssertNotEqual(vm.selectedCategory, newCategory)
        XCTAssertEqual(vm.mealCatogries, collection)
    }
}
