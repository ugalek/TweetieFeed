//
//  LinkType.swift
//  
//
//  Created by Galina on 26/02/2022.
//

import Foundation

public enum LinkType {
    case mention
    case hashtag
    case url
    
    var pattern: String {
        switch self {
        case .mention: return RegexParser.mentionPattern
        case .hashtag: return RegexParser.hashtagPattern
        case .url: return RegexParser.urlPattern
        }
    }
}

enum LinkElement {
    case mention(String)
    case hashtag(String)
    case url(original: String, trimmed: String)
    
    static func create(with linkType: LinkType, text: String) -> LinkElement {
        switch linkType {
        case .mention: return mention(text)
        case .hashtag: return hashtag(text)
        case .url: return url(original: text, trimmed: text)
        }
    }
}

extension LinkType: Hashable, Equatable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .mention: hasher.combine(-1)
        case .hashtag: hasher.combine(-2)
        case .url: hasher.combine(-3)
        }
    }
}

public func ==(lhs: LinkType, rhs: LinkType) -> Bool {
    switch (lhs, rhs) {
    case (.mention, .mention): return true
    case (.hashtag, .hashtag): return true
    case (.url, .url): return true
    default: return false
    }
}
