//
//  Media.swift
//  
//
//  Created by Galina on 25/02/2022.
//

import Foundation

struct Media: Codable, Identifiable, Hashable {
    enum CodingKeys: String, CodingKey {
        // Map the JSON keys to the Swift property names
        case id = "id_str"
        case mediaUrlHttps = "media_url_https"
        case type
        case videoInfo = "video_info"
    }
    
    let id: String
    let mediaUrlHttps: String
    let type: String
    let videoInfo: MediaVideoInfo?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        mediaUrlHttps = try values.decode(String.self, forKey: .mediaUrlHttps)
        type = try values.decode(String.self, forKey: .type)
        videoInfo = try values.decodeIfPresent(MediaVideoInfo.self, forKey: .videoInfo)
    }
    
    init(id: String, mediaUrlHttps: String, type: String, videoInfo: MediaVideoInfo?) {
        
        self.id = id
        self.mediaUrlHttps = mediaUrlHttps
        self.type = type
        self.videoInfo = videoInfo
    }
}
