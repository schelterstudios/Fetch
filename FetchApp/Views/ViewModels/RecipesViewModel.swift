//
//  RecipesViewModel.swift
//  FetchApp
//
//  Created by Steve Schelter on 3/2/25.
//

import Foundation

@Observable
final class RecipesViewModel {
    
    private(set) var recipes: [Recipe] = []
    private(set) var selectedRecipe: Recipe?
    
    private let service: RecipeServicing
    
    init(_ service: RecipeServicing = RecipeService.shared) {
        self.service = service
    }
    
    func reload() async throws {
        let newRecipes = try await service.fetchRecipes()
        if recipes != newRecipes {
            self.recipes = newRecipes
            selectedRecipe = newRecipes.first
        }
    }
    
    func select(_ recipe: Recipe) {
        self.selectedRecipe = recipe
    }
}
