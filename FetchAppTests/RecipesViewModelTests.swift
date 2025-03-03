//
//  RecipesViewModelTests.swift
//  FetchAppTests
//
//  Created by Steve Schelter on 3/2/25.
//

@testable import FetchApp
import Foundation
import Testing

struct RecipesViewModelTests {

    @Test("Successfully reloading")
    func reload() async throws {
        let service = RecipeServicingMock()
        service.fetchRecipesHandler = { [Recipe.test1, Recipe.test2] }
        let viewModel = RecipesViewModel(service)
        #expect(viewModel.recipes.count == 0)
        try await viewModel.reload()
        #expect(viewModel.recipes.count == 2)
        #expect(viewModel.selectedRecipe == Recipe.test1)
        
        // testing reload with no data change
        viewModel.select(Recipe.test2)
        #expect(viewModel.selectedRecipe == Recipe.test2)
        try await viewModel.reload()
        #expect(viewModel.recipes.count == 2)
        #expect(viewModel.selectedRecipe == Recipe.test2)
    }
    
    @Test("Successfully reloading with new data")
    func reload_withNewData() async throws {
        let service = RecipeServicingMock()
        service.fetchRecipesHandler = { [Recipe.test1] }
        let viewModel = RecipesViewModel(service)
        #expect(viewModel.recipes.count == 0)
        try await viewModel.reload()
        #expect(viewModel.recipes.count == 1)
        #expect(viewModel.selectedRecipe == Recipe.test1)
        
        // testing reload with data change
        service.fetchRecipesHandler = { [Recipe.test2] }
        try await viewModel.reload()
        #expect(viewModel.recipes.count == 1)
        #expect(viewModel.selectedRecipe == Recipe.test2)
    }
    
    @Test("Error reloading")
    func reload_withError() async throws {
        let service = RecipeServicingMock()
        service.fetchRecipesHandler = { throw TestError.mocked }
        let viewModel = RecipesViewModel(service)
        
        await #expect(throws: TestError.mocked) {
            try await viewModel.reload()
        }
    }
}

private class RecipeServicingMock: RecipeServicing {
    
    var fetchRecipesHandler: (() async throws -> [Recipe])?
    
    func fetchRecipes() async throws -> [Recipe] {
        guard let fetchRecipesHandler else {
            throw NSError(domain: "test", code: 0)
        }
        return try await fetchRecipesHandler()
    }
}

enum TestError: Error {
    case mocked
}

extension Recipe {
    static var test1: Recipe {
        Recipe(
            id: "1",
            name: "Cheeseburger",
            cuisine: "American",
            photos: [],
            sourceURL: nil,
            youtubeURL: nil
        )
    }
    
    static var test2: Recipe {
        Recipe(
            id: "2",
            name: "Tacos",
            cuisine: "Mexican",
            photos: [],
            sourceURL: nil,
            youtubeURL: nil
        )
    }
}
