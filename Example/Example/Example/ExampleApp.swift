//
//  ExampleApp.swift
//  Example
//
//  Created by Galina on 06/03/2022.
//

import SwiftUI
import TweetieFeed

@main
struct ExampleApp: App {
    @StateObject var uiSettings = TweetieFeedUISettings(footerTextColor: .cyan)
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ExampleViewModel())
                .environmentObject(uiSettings)
        }
    }
}
