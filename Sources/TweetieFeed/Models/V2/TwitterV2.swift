//
//  TwitterV2.swift
//  
//
//  Created by Galina on 03/03/2022.
//

import Foundation

class TwitterV2: Codable {
    let data: [TwitterData]?
    let includes: TwitterIncludes?
    
    init(data: [TwitterData]?, includes: TwitterIncludes?) {
        
        self.data = data
        self.includes = includes
    }
}
