//
//  Twitter.swift
//  
//
//  Created by Galina on 25/02/2022.
//

import Foundation

public final class Twitter: Codable, Identifiable, Hashable {
    public static func == (lhs: Twitter, rhs: Twitter) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        // Map the JSON keys to the Swift property names
        case id = "id_str"
        case createdAt = "created_at"
        case text = "full_text"
        case retweetedStatus = "retweeted_status"
        case entities = "extended_entities"
        case quotedStatus = "quoted_status"
        case user
        case retweet = "retweet_count"
        case favorite = "favorite_count"
    }
    
    public let id: String
    
    // creation date of tweet
    let createdAt: String
    
    // text of tweet
    let text: String
        
    // retweeted tweet
    let retweetedStatus: Twitter?
    
    // entities with media files
    var entities: Entities?
    
    // quoted tweet
    let quotedStatus: Twitter?
    
    // user information
    let user: User
    
    // count of retweets
    let retweet: Int
    
    // count of favorites
    let favorite: Int
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        text = try values.decode(String.self, forKey: .text)
        retweetedStatus = try values.decodeIfPresent(Twitter.self, forKey: .retweetedStatus)
        entities = try values.decodeIfPresent(Entities.self, forKey: .entities)
        quotedStatus = try values.decodeIfPresent(Twitter.self, forKey: .quotedStatus)
        user = try values.decode(User.self, forKey: .user)
        retweet = try values.decode(Int.self, forKey: .retweet)
        favorite = try values.decode(Int.self, forKey: .favorite)
    }
    
    init(id: String, createdAt: String, text: String, retweetedStatus: Twitter?,
         entities: Entities?, quotedStatus: Twitter?, user: User, retweet: Int, favorite: Int) {
        
        self.id = id
        self.createdAt = createdAt
        self.text = text
        self.retweetedStatus = retweetedStatus
        self.entities = entities
        self.quotedStatus = quotedStatus
        self.user = user
        self.retweet = retweet
        self.favorite = favorite
    }
}

