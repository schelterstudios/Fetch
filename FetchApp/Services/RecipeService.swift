//
//  RecipeService.swift
//  FetchApp
//
//  Created by Steve Schelter on 3/1/25.
//

import Foundation

private struct FetchRecipesResponse: Decodable {
    let recipes: [Recipe]
}

struct RecipeService {
    
    static let shared = RecipeService()
    
    private let recipesURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    
    func fetchRecipes() async throws -> [Recipe] {
        let result = try await URLSession.shared.data(from: recipesURL)
        let json = try JSONSerialization.jsonObject(with: result.0)
        print("JSON =",json)
        let recipes = try JSONDecoder()
            .decode(FetchRecipesResponse.self, from: result.0)
            .recipes
        print("Objs =",recipes)
        return recipes
    }
}
