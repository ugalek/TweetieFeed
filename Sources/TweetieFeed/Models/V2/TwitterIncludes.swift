//
//  TwitterIncludes.swift
//  
//
//  Created by Galina on 03/03/2022.
//

import Foundation

struct TwitterIncludes: Codable {
    let tweets: [TwitterData]?
    let users: [UserV2]?
    let media: [MediaV2]?
}
