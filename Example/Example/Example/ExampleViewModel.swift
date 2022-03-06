//
//  ExampleViewModel.swift
//  Example
//
//  Created by Galina on 06/03/2022.
//

import Foundation
import TweetieFeed

class ExampleViewModel: ObservableObject {
    @Published var dataReceived: Bool
    var feedDecoder: TweetieFeedDecoder?
    
    init(dataReceived: Bool = false, feedDecoder: TweetieFeedDecoder? = nil) {
        self.dataReceived = dataReceived
        self.feedDecoder = feedDecoder
    }
    
    func getData(version: TwitterAPIVersion = .v1) {
        dataReceived = false
        let userName = ""
        let userID = ""
        let bearer = ""
        
        let URLv1 = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(userName)&count=30&tweet_mode=extended"
        let URLv2 = "https://api.twitter.com/2/users/\(userID)/tweets?expansions=attachments.media_keys,in_reply_to_user_id,referenced_tweets.id,author_id,entities.mentions.username&tweet.fields=attachments,author_id,created_at,entities,id,in_reply_to_user_id,possibly_sensitive,reply_settings,text,public_metrics&user.fields=created_at,description,entities,id,name,profile_image_url,username&media.fields=height,media_key,preview_image_url,type,url,width&max_results=30"
        
        var request = URLRequest(url: URL(string: version == .v1 ? URLv1 : URLv2)!, timeoutInterval: Double.infinity)
        request.addValue("Bearer \(bearer)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            DispatchQueue.main.async {
                self.feedDecoder = TweetieFeedDecoder(data: data, version: version)
                self.dataReceived = true
            }
        }
        task.resume()
    }
}
