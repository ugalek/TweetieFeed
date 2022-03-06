//
//  ImageCache.swift
//  
//
//  Created by Galina on 26/02/2022.
//

#if !os(macOS)
import UIKit

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}
#endif
