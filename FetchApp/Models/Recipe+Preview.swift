//
//  Recipe+Preview.swift
//  FetchApp
//
//  Created by Steve Schelter on 3/1/25.
//

import Foundation

extension Recipe {
    static var preview: Recipe {
        Recipe(
            id: "1",
            name: "Cheeseburger",
            cuisine: "American",
            photos: [
                .init("https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg", size: .large)!,
                .init("https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg", size: .small)!
            ],
            sourceURL: nil,
            youtubeURL: nil
        )
    }
}
