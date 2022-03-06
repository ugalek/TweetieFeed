//
//  MediaV2.swift
//  
//
//  Created by Galina on 03/03/2022.
//

import Foundation

struct MediaV2: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        // Map the JSON keys to the Swift property names
        case mediaKey = "media_key"
        case height
        case width
        case type
        case url
        case previewImageURL = "preview_image_url"
    }
    
    let mediaKey: String
    let height: Int
    let width: Int
    let type: String
    let url: String?
    let previewImageURL: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        mediaKey = try values.decode(String.self, forKey: .mediaKey)
        height = try values.decode(Int.self, forKey: .height)
        width = try values.decode(Int.self, forKey: .width)
        type = try values.decode(String.self, forKey: .type)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        previewImageURL = try values.decodeIfPresent(String.self, forKey: .previewImageURL)
    }
    
    init(mediaKey: String, height: Int, width: Int, type: String, url: String?, previewImageURL: String?) {
        
        self.mediaKey = mediaKey
        self.height = height
        self.width = width
        self.type = type
        self.url = url
        self.previewImageURL = previewImageURL
    }
}
