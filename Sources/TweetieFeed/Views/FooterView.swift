//
//  FooterView.swift
//  
//
//  Created by Galina on 26/02/2022.
//

import SwiftUI

struct FooterView: View {
    @EnvironmentObject var uiSettings: TweetieFeedUISettings
    @State var tweet: Twitter
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "arrow.2.squarepath")
                Text(String(tweet.retweet))
                Image(systemName: "heart")
                Text(String(tweet.favorite))
            }
            .foregroundColor(uiSettings.footerTextColor)
            Spacer()
            Link(tweet.createdAt.toDateString(locale: uiSettings.localeIdentifier),
                 destination: getUrl(with: "\(twitterURLString)/\(tweet.user.screenName)/status/\(tweet.id)"))
                .font(.footnote)
        }
    }
    
    func getUrl(with urlString: String) -> URL {
        guard let url = URL(string: urlString) else {
            return twitterURL
        }
        return url
    }
}

#if DEBUG
struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView(tweet: staticTwitter)
            .previewLayout(.sizeThatFits)
            .environmentObject(TweetieFeedUISettings())
    }
}
#endif
