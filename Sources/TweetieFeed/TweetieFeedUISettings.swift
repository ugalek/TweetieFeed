//
//  TweetieFeedUISettings.swift
//  
//
//  Created by Galina on 04/03/2022.
//

import SwiftUI

/// General customasible UI settings that affects views and controls
///
public class TweetieFeedUISettings: ObservableObject {
        
    /// The color to use for UI background at the dark mode.
    public let backgroundDark: Color
    
    /// The color to use for UI background at the light mode.
    public let backgroundLight: Color
    
    /// The color to use for tweet background at the dark mode.
    public let tweetBackgroundDark: Color
    
    /// The color to use for tweet background at the light mode.
    public let tweetBackgroundLight: Color
    
    /// The color to use for tweet border at the dark mode.
    public let tweetBorderDark: Color
    
    /// The color to use for tweet border at the light mode.
    public let tweetBorderLight: Color

    /// The color to use for retweeted status text.
    public let retweetedStatusTextColor: Color
    
    /// The color to use for text in the footer (retweet & favorite).
    public let footerTextColor: Color

    public let tweetBodyCornerRadius: CGFloat
    
    public let localeIdentifier: String
    
    /**
     The style of the `List`. Defaults to `.plainListStyle`.
     */
    public let listStyle: CustomListStyle

    public init(backgroundDark: Color = Color(red: 8 / 255, green: 21 / 255, blue: 38 / 255),
                backgroundLight: Color = Color(red: 228 / 255, green: 232 / 255, blue: 240 / 255),
                tweetBackgroundDark: Color = Color(red: 0, green: 0, blue: 0),
                tweetBackgroundLight: Color = Color(red: 255, green: 255, blue: 255),
                tweetBorderDark: Color = Color(red: 47 / 255, green: 51 / 255, blue: 54 / 255),
                tweetBorderLight: Color = Color(red: 235 / 255, green: 238 / 255, blue: 240 / 255),
                retweetedStatusTextColor: Color = Color.secondary,
                footerTextColor: Color = Color.gray,
                tweetBodyCornerRadius: CGFloat = 15,
                localeIdentifier: String = "en_US",
                listStyle: CustomListStyle = CustomListStyle.plainListStyle) {
        self.backgroundDark = backgroundDark
        self.backgroundLight = backgroundLight
        self.tweetBackgroundDark = tweetBackgroundDark
        self.tweetBackgroundLight = tweetBackgroundLight
        self.tweetBorderDark = tweetBorderDark
        self.tweetBorderLight = tweetBorderLight
        self.retweetedStatusTextColor = retweetedStatusTextColor
        self.footerTextColor = footerTextColor
        self.tweetBodyCornerRadius = tweetBodyCornerRadius
        self.localeIdentifier = localeIdentifier
        self.listStyle = listStyle
    }
}

public extension TweetieFeedUISettings {
    enum CustomListStyle {
        
        /**
         Translates into [DefaultListStyle](https://developer.apple.com/documentation/swiftui/defaultliststyle ).
         */
        case defaultListStyle
        
        /**
         Translates into [PlainListStyle](https://developer.apple.com/documentation/swiftui/plainliststyle)
         */
        case plainListStyle
        
        /**
         Translates into [GroupedListStyle](https://developer.apple.com/documentation/swiftui/groupedliststyle ).
         */
        case groupedListStyle
        
        /**
         **iOS 14.0 and above only.** Otherwise, defaults to `defaultListStyle`.
         
         Translates into [InsetGroupedListStyle](https://developer.apple.com/documentation/swiftui/insetgroupedliststyle ).
         */
        case insetGroupedListStyle
        
        /**
         **iOS 14.0 and above only.** Otherwise, defaults to `defaultListStyle`.
         
         Translates into [InsetListStyle](https://developer.apple.com/documentation/swiftui/insetliststyle ).
         */
        case insetListStyle
        
        /**
         **iOS 14.0 and above only.** Otherwise, defaults to `defaultListStyle`.
         
         Translates into [SidebarListStyle](https://developer.apple.com/documentation/swiftui/sidebarliststyle ).
         */
        case sidebarListStyle
        
    }
}
