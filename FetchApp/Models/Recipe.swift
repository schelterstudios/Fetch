//
//  Recipe.swift
//  FetchApp
//
//  Created by Steve Schelter on 3/1/25.
//

import Foundation

struct RecipePhoto {
    
    enum Size: Int {
        case small, large
    }
    
    let url: URL
    let size: Size
    
    init?(_ urlString: String, size: Size) {
        guard let url = URL(string: urlString) else { return nil }
        self.url = url
        self.size = size
    }
}

struct Recipe: Decodable, Identifiable {
    let id: String
    let cuisine: String
    let name: String
    let photos: [RecipePhoto]
    let sourceURL: URL?
    let youtubeURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case uuid
        case photo_url_large
        case photo_url_small
        case source_url
        case youtube_url
    }
    
    init(
        id: String,
        name: String,
        cuisine: String,
        photos: [RecipePhoto],
        sourceURL: URL? = nil,
        youtubeURL: URL? = nil
    ) {
        self.id = id
        self.name = name
        self.cuisine = cuisine
        self.photos = photos
        self.sourceURL = sourceURL
        self.youtubeURL = youtubeURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cuisine = try container.decode(String.self, forKey: .cuisine)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .uuid)
        
        sourceURL = if container.contains(.source_url) {
            try container.decode(String?.self, forKey: .source_url)
                .flatMap(URL.init)
        } else { nil }
        
        youtubeURL = if container.contains(.youtube_url) {
            try container.decode(String?.self, forKey: .youtube_url)
                .flatMap(URL.init)
        } else { nil }
        
        var photos: [RecipePhoto] = []
        if container.contains(.photo_url_small),
           let photo = try container.decode(String?.self, forKey: .photo_url_small)
            .flatMap({ urlString in RecipePhoto(urlString, size: .small) }) {
            photos.append(photo)
        }
        
        if container.contains(.photo_url_large),
           let photo = try container.decode(String?.self, forKey: .photo_url_large)
            .flatMap({ urlString in RecipePhoto(urlString, size: .large) }) {
            photos.append(photo)
        }

        self.photos = photos
    }
}

extension Recipe: Equatable {
    public static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
}

extension RecipePhoto.Size: Comparable {
    static func < (lhs: RecipePhoto.Size, rhs: RecipePhoto.Size) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension RecipePhoto: Comparable {
    static func < (lhs: RecipePhoto, rhs: RecipePhoto) -> Bool {
        return lhs.size < rhs.size
    }
}
