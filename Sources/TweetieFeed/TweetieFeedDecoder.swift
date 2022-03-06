//
//  TweetieFeedDecoder.swift
//  
//
//  Created by Galina on 25/02/2022.
//

import Foundation

let TwitterAPIVersionKey = "TwitterAPIVersion"

public enum TwitterAPIVersion: String, CaseIterable {
    case v1
    case v2
}

@available(iOS 14, macOS 10.15, *)
public class TweetieFeedDecoder: ObservableObject {
    @Published var tweets = [Twitter]()
    @Published var errorDescription: String?

    let version: TwitterAPIVersion
    var users = [User]()
    let data: Data?
    let defaults = UserDefaults.standard
    
    public init(data: Data?, version: TwitterAPIVersion = .v1) {
        self.data = data
        self.version = version
        defaults.set(version.rawValue, forKey: TwitterAPIVersionKey)
    }
    
    /// Decode given data
    /// 
    public func decode() {
        tweets.removeAll()
        if let data = data {
            if version == .v1 {
                decodeV1(data)
            } else {
                decodeV2(data)
            }
        }
    }
    
    fileprivate func decodeV1(_ data: Data) {
        let decoder = JSONDecoder()
        
        do {
            tweets = try decoder.decode([Twitter].self, from: data)
        } catch {
            errorDescription = "TweetieFeedDecoder - Decode error: \(error)."
            print(errorDescription!)
        }
    }
    
    fileprivate func decodeV2(_ data: Data) {
        let decoder = JSONDecoder()
        var tweetsV2: TwitterV2?
        var referencedTweets = [Twitter]()
        var quotedStatus: Twitter?
        var retweetedStatus: Twitter?
        
        do {
            tweetsV2 = try decoder.decode(TwitterV2.self, from: data)
        } catch {
            errorDescription = "TweetieFeedDecoder - Decode error: \(error)."
            print(errorDescription!)
        }
        
        // Create an array of users
        if let usersV2 = tweetsV2?.includes?.users {
            for user in usersV2 {
                users.append(User(id: user.id,
                                      name: user.name,
                                      screenName: user.username,
                                  profileImageURLHTTPs: user.profileImageURL ?? "https://dummyimage.com/squarepopup"))
            }
        }
        
        // Create an array with referenced tweets
        if let tweets = tweetsV2?.includes?.tweets {
            for tweet in tweets {
                if let user = users.first(where: {$0.id == tweet.authorID}) {
                    referencedTweets.append(Twitter(id: tweet.id,
                                                     createdAt: tweet.createdAt,
                                                     text: tweet.text,
                                                     retweetedStatus: nil,
                                                     entities: nil,
                                                     quotedStatus: nil,
                                                     user: user,
                                                     retweet: tweet.publicMetrics?.retweet ?? 0,
                                                     favorite: tweet.publicMetrics?.like ?? 0))
                }
            }
        }
        
        // Create an array with media
        var mediasAll = [Media]()
        if let mediaV2 = tweetsV2?.includes?.media {
            for media in mediaV2 {
                let mediaUrlHttps = media.url ?? "https://dummyimage.com/squarepopup"
                if media.type == "photo" {
                    mediasAll.append(Media(id: media.mediaKey,
                                           mediaUrlHttps: mediaUrlHttps,
                                        type: media.type,
                                        videoInfo: nil))
                } else if media.type == "video" {
                    let videoInfo = MediaVideoInfo(variants: [MediaVideoVariants(contentType: nil, url: mediaUrlHttps)])
                    mediasAll.append(Media(id: media.mediaKey,
                                        mediaUrlHttps: mediaUrlHttps,
                                        type: "video",
                                        videoInfo: videoInfo))
                }
            }
        }
        
        if let tweetsV2 = tweetsV2?.data {
            for tweet in tweetsV2 {
                if let user = users.first(where: {$0.id == tweet.authorID}) {
                    // Define media files for the current tweet
                    var medias = [Media]()
                    if let mediaKeys = tweet.attachments?.mediaKeys {
                        for key in mediaKeys {
                            if let media = mediasAll.first(where: {$0.id == key}) {
                                medias.append(media)
                            }
                        }
                    }
                    let entities = Entities(hashtags: nil, media: medias, userMentions: nil, urls: nil)
                    
                    // Check if tweet is quoted
                    quotedStatus = nil
                    if let referenced = tweet.referencedTweets {
                        if let quotedTweet = referenced.first(where: {$0.type == "quoted"}) {
                            // Get quoted tweet
                            quotedStatus = referencedTweets.first(where: {$0.id == quotedTweet.id})
                        }
                    }
                    
                    // Check if tweet is retweeted
                    retweetedStatus = nil
                    if let referenced = tweet.referencedTweets {
                        if let retweetedTweet = referenced.first(where: {$0.type == "retweeted"}) {
                            // Get quoted tweet
                            retweetedStatus = referencedTweets.first(where: {$0.id == retweetedTweet.id})
                            retweetedStatus!.entities = entities
                        }
                    }
                    
                    tweets.append(Twitter(id: tweet.id,
                                          createdAt: tweet.createdAt,
                                          text: tweet.text,
                                          retweetedStatus: retweetedStatus,
                                          entities: entities,
                                          quotedStatus: quotedStatus,
                                          user: user,
                                          retweet: tweet.publicMetrics?.retweet ?? 0,
                                          favorite: tweet.publicMetrics?.like ?? 0))
                }
            }
        }
    }
}
