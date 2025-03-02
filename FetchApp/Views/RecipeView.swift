//
//  RecipeView.swift
//  FetchApp
//
//  Created by Steve Schelter on 3/1/25.
//

import SwiftUI

struct RecipeView: View {
    
    let recipe: Recipe
    let expanded: Bool
    
    var body: some View {
        if expanded {
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                if let photo = recipe.photos.sorted().last {
                    CachedImageView(url: photo.url) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .clipped()
                } else {
                    Spacer().frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
        
        } else {
            HStack {
                if let photo = recipe.photos.sorted().first {
                    CachedImageView(url: photo.url) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 50, height: 50)
                    .clipped()
                } else {
                    Color.gray.frame(width: 50, height: 50)
                }
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.headline)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Text(recipe.cuisine)
                        .font(.subheadline)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                Spacer()
            }
        }
    }
}

#Preview("Compact", traits: .fixedLayout(width: 300, height: 60)) {
    RecipeView(recipe: .preview, expanded: false)
        .environment(ImageCache())
}

#Preview("Expanded", traits: .fixedLayout(width: 300, height: 300)) {
    RecipeView(recipe: .preview, expanded: true)
        .environment(ImageCache())
}
