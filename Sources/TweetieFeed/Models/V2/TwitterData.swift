//
//  TwitterData.swift
//  
//
//  Created by Galina on 03/03/2022.
//

import Foundation

struct TwitterData: Codable, Identifiable, Hashable {
    static func == (lhs: TwitterData, rhs: TwitterData) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        // Map the JSON keys to the Swift property names
        case id
        case authorID = "author_id"
        case createdAt = "created_at"
        case referencedTweets = "referenced_tweets"
        case text
        case possiblySensitive = "possibly_sensitive"
        case publicMetrics = "public_metrics"
        case attachments
    }
    
    let id: String
    
    let authorID: String?
    let createdAt: String
    let referencedTweets: [ReferencedTweets]?
    let text: String
    let possiblySensitive: Bool?
    let publicMetrics: PublicMetrics?
    let attachments: Attachments?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        authorID = try values.decodeIfPresent(String.self, forKey: .authorID)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        referencedTweets = try values.decodeIfPresent([ReferencedTweets].self, forKey: .referencedTweets)
        text = try values.decode(String.self, forKey: .text)
        possiblySensitive = try values.decodeIfPresent(Bool.self, forKey: .possiblySensitive)
        publicMetrics = try values.decodeIfPresent(PublicMetrics.self, forKey: .publicMetrics)
        attachments = try values.decodeIfPresent(Attachments.self, forKey: .attachments)
    }
    
    init(id: String, authorID: String?, createdAt: String,
         referencedTweets: [ReferencedTweets]?, text: String,
         possiblySensitive: Bool?, publicMetrics: PublicMetrics?, attachments: Attachments?) {
        
        self.id = id
        self.authorID = authorID
        self.createdAt = createdAt
        self.referencedTweets = referencedTweets
        self.text = text
        self.possiblySensitive = possiblySensitive
        self.publicMetrics = publicMetrics
        self.attachments = attachments
    }
}
