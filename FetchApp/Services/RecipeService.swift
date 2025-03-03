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

<<<<<<< HEAD
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
=======
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
        let recipes = try JSONDecoder()
            .decode(FetchRecipesResponse.self, from: result.0)
            .recipes
>>>>>>> a263706 (Initial Commit)
        return recipes
    }
}
