//
//  RecipesView.swift
//  FetchApp
//
//  Created by Steve Schelter on 3/1/25.
//

import SwiftUI

struct RecipesView: View {
    
    let viewModel: RecipesViewModel
    @State private var error: Error?
    @State private var errorPresented: Bool = false
    
    var body: some View {
        VStack {
            if viewModel.recipes.isEmpty {
                emptyView
                
            } else {
                listView
            }
        }
        .padding()
        .task {
            do {
                try await viewModel.reload()
            } catch {
                self.error = error
                self.errorPresented = true
            }
        }
        .alert("Error", isPresented: $errorPresented) {
            
        } message: {
            Text(error?.localizedDescription ?? "Unknown Error")
        }
    }
    
    private var emptyView: some View {
        VStack {
            Text("No Recipes Found!")
            Button {
                Task {
                    do {
                        try await viewModel.reload()
                    } catch {
                        self.error = error
                        self.errorPresented = true
                    }
                }
            } label: {
                Text("Refresh")
            }
        }
    }
    
    private var listView: some View {
        List(viewModel.recipes) { recipe in
            RecipeView(
                recipe: recipe,
                expanded: recipe == viewModel.selectedRecipe
            )
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.select(recipe)
            }
        }
        .refreshable {
            do {
                try await viewModel.reload()
            } catch {
                self.error = error
                self.errorPresented = true
            }
        }
    }
}
