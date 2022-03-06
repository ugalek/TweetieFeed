//
//  MediaVideoInfo.swift
//  
//
//  Created by Galina on 25/02/2022.
//

import Foundation

struct MediaVideoInfo: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        // Map the JSON keys to the Swift property names
        case variants
    }
    
    let variants: [MediaVideoVariants]?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        variants = try values.decodeIfPresent([MediaVideoVariants].self, forKey: .variants)
    }
    
    init(variants: [MediaVideoVariants]?) {
        self.variants = variants
    }
}

struct MediaVideoVariants: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        // Map the JSON keys to the Swift property names
        case contentType = "content_type"
        case url
    }
    
    let contentType: String?
    let url: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        contentType = try values.decodeIfPresent(String.self, forKey: .contentType)
        url = try values.decode(String.self, forKey: .url)
    }
    
    init(contentType: String?, url: String) {
        self.contentType = contentType
        self.url = url
    }
}
