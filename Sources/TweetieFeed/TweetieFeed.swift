//
//  TweetieFeed.swift
//
//
//  Created by Galina on 25/02/2022.
//

import SwiftUI

/// This view is a container that displays twitter feed
///
public struct TweetieFeedView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var tweetieDecoder: TweetieFeedDecoder
    @EnvironmentObject var uiSettings: TweetieFeedUISettings
    
    var currentTweets: [Twitter] {
        get {
            if !tweetieDecoder.tweets.isEmpty {
                return tweetieDecoder.tweets
            }
            return []
        }
    }
    
    public init(tweetieDecoder: TweetieFeedDecoder) {
        self.tweetieDecoder = tweetieDecoder
    }
    
    public var body: some View {
        content
    }
    
    private var content: some View {
        VStack {
            if tweetieDecoder.errorDescription != nil {
                VStack {
                    Text(tweetieDecoder.errorDescription!)
                }
            } else {
                if currentTweets.count > 0 {
                    List {
                        ForEach(currentTweets, id: \.self) { tweet in
                            if #available(iOS 15.0, *) {
                                TweetView(tweet: tweet)
                                    .listRowSeparator(.hidden)
                            } else {
                                TweetView(tweet: tweet)
                            }
                        }
                        .listRowBackground(colorScheme == .dark ? uiSettings.backgroundDark : uiSettings.backgroundLight)
                    }
                    .listStyle(.grouped)
                } else {
                    Text("No data to display")
                }
            }
        }
        .onAppear(perform: decodeData)
    }
    
    private func decodeData() {
        tweetieDecoder.decode()
    }
}

