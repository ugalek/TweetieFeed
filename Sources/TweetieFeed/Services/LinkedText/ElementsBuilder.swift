//
//  ElementsBuilder.swift
//  
//
//  Created by Galina on 26/02/2022.
//

import Foundation

typealias ElementTuple = (range: NSRange, element: LinkElement, type: LinkType, text: String)

//See https://github.com/optonaut/ActiveLabel.swift
struct ElementsBuilder {

    static func createElements(types: [LinkType], from text: String, range: NSRange) -> [ElementTuple] {
        var tuple = [ElementTuple]()
        for type in types {
            switch type {
            case .mention, .hashtag:
                tuple.append(contentsOf: createElementsIgnoringFirstCharacter(from: text, for: type, range: range))
            case .url:
                tuple.append(contentsOf: createElements(from: text, for: type, range: range))
            }
        }
        return tuple
    }

    static func createURLElements(from text: String, range: NSRange, maximumLength: Int?) -> ([ElementTuple], String) {
        let type = LinkType.url
        var text = text
        let matches = RegexParser.getElements(from: text, with: type.pattern, range: range)
        let nsstring = text as NSString
        var elements: [ElementTuple] = []

        for match in matches where match.range.length > 2 {
            let word = nsstring.substring(with: match.range)
                .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

            guard let maxLength = maximumLength, word.count > maxLength else {
                let range = maximumLength == nil ? match.range : (text as NSString).range(of: word)
                let element = LinkElement.create(with: type, text: word)
                elements.append((range, element, type, word))
                continue
            }

            let trimmedWord = word.trim(to: maxLength)
            text = text.replacingOccurrences(of: word, with: trimmedWord)

            let newRange = (text as NSString).range(of: trimmedWord)
            let element = LinkElement.url(original: word, trimmed: trimmedWord)
            elements.append((newRange, element, type, trimmedWord))
            
        }
        return (elements, text)
    }

    private static func createElements(from text: String,
                                            for type: LinkType,
                                                range: NSRange,
                                                minLength: Int = 2) -> [ElementTuple] {

        let matches = RegexParser.getElements(from: text, with: type.pattern, range: range)
        let nsstring = text as NSString
        var elements: [ElementTuple] = []

        for match in matches where match.range.length > minLength {
            let word = nsstring.substring(with: match.range)
                .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let element = LinkElement.create(with: type, text: word)
            elements.append((match.range, element, type, word))
        }
        
        return elements
    }

    private static func createElementsIgnoringFirstCharacter(from text: String,
                                                                  for type: LinkType,
                                                                      range: NSRange) -> [ElementTuple] {
        let matches = RegexParser.getElements(from: text, with: type.pattern, range: range)
        let nsstring = text as NSString
        var elements: [ElementTuple] = []

        for match in matches where match.range.length > 2 {
            let range = NSRange(location: match.range.location + 1, length: match.range.length - 1)
            var word = nsstring.substring(with: range)
            if word.hasPrefix("@") {
                word.remove(at: word.startIndex)
            }
            else if word.hasPrefix("#") {
                word.remove(at: word.startIndex)
            }
            
            let element = LinkElement.create(with: type, text: word)
            elements.append((match.range, element, type, word))
        }
        
        return elements
    }
}
