//
//  TweetView.swift
//  
//
//  Created by Galina on 26/02/2022.
//

import SwiftUI

struct TweetView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var uiSettings: TweetieFeedUISettings
    let tweet: Twitter
    var isEmbedded = false
    var inLine = false
    
    var body: some View {
        ZStack {
            if !isEmbedded {
                if colorScheme == .dark {
                    uiSettings.backgroundDark.edgesIgnoringSafeArea(.all)
                } else {
                    uiSettings.backgroundLight.edgesIgnoringSafeArea(.all)
                }
            }
            RoundedRectangle(cornerRadius: uiSettings.tweetBodyCornerRadius)
                .fill(colorScheme == .dark ? uiSettings.tweetBackgroundDark : uiSettings.tweetBackgroundLight)
                .overlay(
                    RoundedRectangle(cornerRadius: uiSettings.tweetBodyCornerRadius)
                        .stroke(colorScheme == .dark ? uiSettings.tweetBorderDark : uiSettings.tweetBorderLight, lineWidth: 1))
                .padding(.all, 2)
            
            
            VStack(alignment: .leading, spacing: nil) {
                if !tweet.text.hasPrefix("RT") {
                    HeadlineView(tweet: tweet, inLine: inLine)
                    TweetTextView(textString: tweet.text)
                    MediaView(tweet: tweet)
                }
                
                if let hasEmbeddedTweet = tweet.retweetedStatus {
                    HStack {
                        Image(systemName: "arrow.2.squarepath")
                        Text("\(tweet.user.name) Retweeted")
                    }
                    .foregroundColor(uiSettings.retweetedStatusTextColor)
                    .font(.subheadline)
                    TweetView(tweet: hasEmbeddedTweet, isEmbedded: true)
                } else if let hasEmbeddedTweet = tweet.quotedStatus {
                    TweetView(tweet: hasEmbeddedTweet, isEmbedded: true, inLine: true)
                }
                
                Spacer()
                if !isEmbedded {
                    Divider()
                    FooterView(tweet: tweet)
                }
            }
            .padding(.all, 10)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity)
    }
}

#if DEBUG
struct TweetView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            if #available(iOS 15.0, *) {
                TweetView(tweet: staticTwitter)
                    .listRowBackground(TweetieFeedUISettings().backgroundLight)
                    .listRowSeparator(.hidden)
            } else {
                TweetView(tweet: staticTwitter)
                    .listRowBackground(TweetieFeedUISettings().backgroundLight)
            }
            TweetView(tweet: staticRTTwitter)
                .listRowBackground(TweetieFeedUISettings().backgroundLight)
            TweetView(tweet: staticQuotedTwitter)
                .listRowBackground(TweetieFeedUISettings().backgroundLight)
        }
        .listStyle(.grouped)
        .environmentObject(TweetieFeedUISettings())
    }
}
#endif
