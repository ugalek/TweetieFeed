//
//  Attachments.swift
//  
//
//  Created by Galina on 03/03/2022.
//

import Foundation

struct Attachments: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        // Map the JSON keys to the Swift property names
        case mediaKeys = "media_keys"
    }
    
    let mediaKeys: [String]?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        mediaKeys = try values.decodeIfPresent([String].self, forKey: .mediaKeys)
    }
    
    init(mediaKeys: [String]?) {
        
        self.mediaKeys = mediaKeys
    }
}
