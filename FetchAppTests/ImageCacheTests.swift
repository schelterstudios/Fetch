//
//  ImageCacheTests.swift
//  FetchAppTests
//
//  Created by Steve Schelter on 3/2/25.
//

@testable import FetchApp
import SwiftUI
import Testing

struct ImageCacheTests {
    
    @Test("Successfully caching an image")
    func imageCached() async throws {
        let mock = ImageFetcherMock()
        let cache = await ImageCache(mock)
        
        // first load triggers fetch
        try await confirmation(expectedCount: 1) { fetched in
            mock.fetchImageHandler = { url in
                defer { fetched() }
                try await Task.sleep(for: .seconds(0.1))
                return Image(systemName: "pencil")
            }
            let image = await cache[URL(string: "https://google.com")!]
            try await Task.sleep(for: .seconds(0.2))
            #expect(image == nil)
        }
        
        // second load does not trigger fetch
        await confirmation(expectedCount: 0) { fetched in
            mock.fetchImageHandler = { url in
                defer { fetched() }
                try await Task.sleep(for: .seconds(0.1))
                return Image(systemName: "pencil")
            }
            let image = await cache[URL(string: "https://google.com")!]
            #expect(image != nil)
        }
    }
    
    @Test("Error while caching an image")
    func imageCached_failure() async throws {
        let mock = ImageFetcherMock()
        let cache = await ImageCache(mock)
        
        // first load triggers fetch
        try await confirmation(expectedCount: 1) { fetched in
            mock.fetchImageHandler = { url in
                defer { fetched() }
                throw NSError(domain: "test", code: 0)
            }
            let image = await cache[URL(string: "https://google.com")!]
            try await Task.sleep(for: .seconds(0.1))
            #expect(image == nil)
        }
        
        // second load does not trigger fetch
        await confirmation(expectedCount: 0) { fetched in
            mock.fetchImageHandler = { url in
                defer { fetched() }
                throw NSError(domain: "test", code: 0)
            }
            let image = await cache[URL(string: "https://google.com")!]
            #expect(image == nil)
        }
    }
}

private class ImageFetcherMock: ImageFetcher {
    
    var fetchImageHandler: ((URL) async throws -> Image)?
    
    func fetchImage(from url: URL) async throws -> Image {
        guard let fetchImageHandler else {
            throw NSError(domain: "test", code: 0)
        }
        return try await fetchImageHandler(url)
    }
}
