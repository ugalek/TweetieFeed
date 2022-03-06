//
//  PublicMetrics.swift
//  
//
//  Created by Galina on 03/03/2022.
//

import Foundation

struct PublicMetrics: Codable {
    
    enum CodingKeys: String, CodingKey {
        // Map the JSON keys to the Swift property names
        case retweet = "retweet_count"
        case reply = "reply_count"
        case like = "like_count"
        case quote = "quote_count"
    }
    
    let retweet: Int
    let reply: Int
    let like: Int
    let quote: Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        retweet = try values.decode(Int.self, forKey: .retweet)
        reply = try values.decode(Int.self, forKey: .reply)
        like = try values.decode(Int.self, forKey: .like)
        quote = try values.decode(Int.self, forKey: .quote)
    }
    
    init(retweet: Int, reply: Int, like: Int, quote: Int) {
        
        self.retweet = retweet
        self.reply = reply
        self.like = like
        self.quote = quote
    }
}
