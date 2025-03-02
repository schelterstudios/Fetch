//
//  ContentView.swift
//  FetchApp
//
//  Created by Steve Schelter on 3/1/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var recipes: [Recipe] = []
    @State private var selectedRecipe: Recipe?
    
    var body: some View {
        VStack {
            List(recipes) { recipe in
                RecipeView(
                    recipe: recipe,
                    expanded: recipe == selectedRecipe
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedRecipe = recipe
                }
            }
        }
        .padding()
        .task {
            do {
                recipes = try await RecipeService.shared.fetchRecipes()
                print(recipes)
            } catch {
                print(error)
                //status = "Fetch Error"
            }
        }
    }
}

#Preview {
    ContentView()
}
