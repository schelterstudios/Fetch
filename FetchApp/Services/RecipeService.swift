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

protocol RecipeServicing {
    func fetchRecipes() async throws -> [Recipe]
}

struct RecipeService: RecipeServicing {
    
    static let shared = RecipeService("recipes.json")
    static let sharedMalformed = RecipeService("recipes-malformed.json")
    static let sharedEmpty = RecipeService("recipes-empty.json")
    
    private let endpoint: String
    private let basePath = "https://d3jbb8n5wk0qxi.cloudfront.net/"
    
    init(_ endpoint: String) {
        self.endpoint = endpoint
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: basePath + endpoint) else {
            throw URLError(.unknown)
        }
        let result = try await URLSession.shared.data(from: url)
        return try JSONDecoder()
            .decode(FetchRecipesResponse.self, from: result.0)
            .recipes
    }
}
