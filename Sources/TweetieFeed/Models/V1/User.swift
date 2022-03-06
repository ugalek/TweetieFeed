//
//  User.swift
//  
//
//  Created by Galina on 25/02/2022.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    enum CodingKeys: String, CodingKey {
        // Map the JSON keys to the Swift property names
        case id = "id_str"
        case name
        case screenName = "screen_name"
        case profileImageURLHTTPs = "profile_image_url_https"
    }
    
    let id: String
    let name: String
    let screenName: String
    let profileImageURLHTTPs: String
    
    init(id: String, name: String, screenName: String, profileImageURLHTTPs: String) {
        
        self.id = id
        self.name = name
        self.screenName = screenName
        self.profileImageURLHTTPs = profileImageURLHTTPs
    }
}
