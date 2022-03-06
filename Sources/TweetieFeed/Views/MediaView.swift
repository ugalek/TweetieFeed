//
//  MediaView.swift
//  
//
//  Created by Galina on 26/02/2022.
//

import SwiftUI
import AVKit

struct MediaView: View {
    @State var tweet: Twitter
    var player: AVPlayer?
   
    fileprivate func showVideo(_ media: Media) -> some View {
        if let videoURL = media.videoInfo?.variants?[0].url {
            return AnyView(VideoPlayer(player: AVPlayer(url: URL(string: videoURL)!))
                .frame(height: UIScreen.main.bounds.height / 3))
        } else {
            return AnyView(EmptyView())
        }
    }
    
    var columns: [GridItem] =
        Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        if let medias = tweet.entities?.media {
            LazyVGrid(columns: columns) {
                ForEach(medias, id: \.self) { media in
                    if media.type == "photo" {
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: URL(string: media.mediaUrlHttps))
                            { image in
                                image
                                    .resizable()
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                            }
                            .scaledToFit()
                            .mask(RoundedRectangle(cornerRadius: 15))
                        } else {
                            // Fallback on earlier versions
                            RemoteImage(url: media.mediaUrlHttps)
                                .scaledToFit()
                        }
                    } else if media.type == "video" {
                        showVideo(media)
                    }
                } // ForEach
            }
        }
    }
}

#if DEBUG
struct MediaView_Previews: PreviewProvider {
    static var previews: some View {
        MediaView(tweet: staticTwitter)
            .previewLayout(.sizeThatFits)
    }
}
#endif

