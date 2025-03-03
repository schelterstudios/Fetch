//
//  CachedImageView.swift
//  FetchApp
//
//  Created by Steve Schelter on 3/2/25.
//

import SwiftUI

@Observable @MainActor
final class ImageCache {
    
    private enum ImagePhase {
        case loading
        case loaded(Image)
    }
    
<<<<<<< HEAD
    private var map: [URL: ImagePhase] = [:]
    
    private func loadImage(from url: URL) {
        guard map[url] == nil else { return }
        Task {
            let r = try await URLSession.shared.data(from: url)
            guard let uiImage = UIImage(data: r.0) else { return }
            let image = Image(uiImage: uiImage)
=======
    private let fetcher: ImageFetcher
    private var map: [URL: ImagePhase] = [:]
    
    init(_ fetcher: ImageFetcher) {
        self.fetcher = fetcher
    }
    
    init() {
        self.fetcher = URLImageFetcher()
    }
    
    private func loadImage(from url: URL) {
        guard map[url] == nil else { return }
        Task {
            let image = try await fetcher.fetchImage(from: url)
>>>>>>> a263706 (Initial Commit)
            map[url] = .loaded(image)
        }
    }
    
    subscript(url: URL) -> Image? {
        get {
            guard let phase = map[url] else {
                loadImage(from: url)
                return nil
            }
            switch phase {
            case .loaded(let image): return image
            case .loading: return nil
            }
        }
    }
}

<<<<<<< HEAD
=======
protocol ImageFetcher {
    func fetchImage(from url: URL) async throws -> Image
}

private struct URLImageFetcher: ImageFetcher {
    func fetchImage(from url: URL) async throws -> Image {
        let r = try await URLSession.shared.data(from: url)
        guard let uiImage = UIImage(data: r.0) else {
            throw URLError(.badServerResponse)
        }
        return Image(uiImage: uiImage)
    }
}

>>>>>>> a263706 (Initial Commit)
struct CachedImageView<Content: View, P: View>: View {
    
    private let url: URL
    @ViewBuilder private let content: (Image) -> Content
    @ViewBuilder private let placeholder: () -> P
    @Environment(ImageCache.self) private var cache
    
    init(
        url: URL,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> P
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }
    
    init(
        url: URL,
        @ViewBuilder content: @escaping (Image) -> Content
    ) where P == Color {
        self.url = url
        self.content = content
        self.placeholder = { Color.gray }
    }
    
    init(
        url: URL
    ) where Content == Image, P == Color {
        self.url = url
        self.content = { $0 }
        self.placeholder = { Color.gray }
    }
    
    var body: some View {
        if let image = cache[url] {
            content(image)
        } else {
            placeholder()
        }
    }
}

#Preview {
    CachedImageView(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg")!)
    .environment(ImageCache())
    .frame(width: 100, height: 100)
}
