//
//  Entities.swift
//  
//
//  Created by Galina on 25/02/2022.
//

import Foundation

struct Entities: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        // Map the JSON keys to the Swift property names
        case hashtags
        case media
        case userMentions = "user_mentions"
        case urls
    }
    
    let hashtags: String?
    let media: [Media]?
    let userMentions: String?
    let urls: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        hashtags = try values.decodeIfPresent(String.self, forKey: .hashtags)
        media = try values.decodeIfPresent([Media].self, forKey: .media)
        userMentions = try values.decodeIfPresent(String.self, forKey: .userMentions)
        urls = try values.decodeIfPresent(String.self, forKey: .urls)
    }
    
    init(hashtags: String?, media: [Media]?, userMentions: String?, urls: String?) {
        
        self.hashtags = hashtags
        self.media = media
        self.userMentions = userMentions
        self.urls = urls
    }
}
