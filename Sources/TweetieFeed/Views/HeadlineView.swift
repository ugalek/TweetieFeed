//
//  HeadlineView.swift
//  
//
//  Created by Galina on 26/02/2022.
//

import SwiftUI

struct HeadlineView: View {
    @State var tweet: Twitter
    var inLine: Bool
        
    var body: some View {
        HStack {
            if inLine {
                Label {
                    Text(tweet.user.name)
                    Text("@\(tweet.user.screenName)")
                } icon: {
                    HeadlineImageView(tweet: tweet)
                        .frame(width: 30, height: 30)
                }
                .font(.subheadline)
            } else {
                HeadlineImageView(tweet: tweet)
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    if #available(iOS 15.0, *) {
                        Text(tweet.user.name)
                            .dynamicTypeSize(.large ... .xxxLarge)
                    } else {
                        Text(tweet.user.name)
                            .font(.headline)
                    }
                    Text("@\(tweet.user.screenName)")
                        .font(.subheadline)
                }
                
            }
            Spacer()
        }
    }
}

struct HeadlineImageView: View {
    @Environment(\.colorScheme) var colorScheme
    var tweet: Twitter
    
    var body: some View {
        HStack{
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: tweet.user.profileImageURLHTTPs))
                { image in
                    image
                        .resizable()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                }
            } else {
                // Fallback on earlier versions
                RemoteImage(url: tweet.user.profileImageURLHTTPs)
                    
            }
        }
        .aspectRatio(contentMode: .fit)
        .scaledToFill()
        .clipShape(Circle())
        .overlay(
            Circle().stroke(colorScheme == .dark ? Color.black : Color.white, lineWidth: 2))
    }
}

#if DEBUG
struct HeadlineView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeadlineView(tweet: staticTwitter, inLine: false)
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
            HeadlineView(tweet: staticTwitter, inLine: true)
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
            HeadlineView(tweet: staticTwitter, inLine: false)
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif
