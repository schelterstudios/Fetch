//
//  FetchAppApp.swift
//  FetchApp
//
//  Created by Steve Schelter on 3/1/25.
//

import SwiftUI

@main
struct FetchAppApp: App {
    
    private let recipesViewModel = RecipesViewModel(RecipeService.shared)
    
    var body: some Scene {
        WindowGroup {
            RecipesView(viewModel: recipesViewModel)
                .environment(ImageCache())
        }
    }
}
