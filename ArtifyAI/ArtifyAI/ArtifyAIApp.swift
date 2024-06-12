//
//  ArtifyAIApp.swift
//  ArtifyAI
//
//  Created by Hesara Mahendra on 2024-06-09.
//

import SwiftUI
import SwiftData

@main
struct ArtifyAIApp: App {
    var body: some Scene {
        WindowGroup {
            UserProfileView()
        }
        .modelContainer(for: ImageModel.self)
    }
}
