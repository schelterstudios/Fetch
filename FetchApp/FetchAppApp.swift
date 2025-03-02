//
//  FetchAppApp.swift
//  FetchApp
//
//  Created by Steve Schelter on 3/1/25.
//

import SwiftUI

@main
struct FetchAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(ImageCache())
        }
    }
}
