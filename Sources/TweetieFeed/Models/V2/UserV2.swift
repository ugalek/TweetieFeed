//
//  UserV2.swift
//  
//
//  Created by Galina on 03/03/2022.
//

import Foundation

struct UserV2: Codable, Identifiable, Hashable {
    enum CodingKeys: String, CodingKey {
        // Map the JSON keys to the Swift property names
        case id
        case name
        case username
        case profileImageURL = "profile_image_url"
    }
    
    let id: String
    let name: String
    let username: String
    let profileImageURL: String?
    
    init(id: String, name: String, username: String, profileImageURL: String?) {
        
        self.id = id
        self.name = name
        self.username = username
        self.profileImageURL = profileImageURL
    }
}
