//
//  TweetTextView.swift
//  
//
//  Created by Galina on 26/02/2022.
//

import SwiftUI
import AttributedText

struct TweetTextView: View {
    @Environment(\.colorScheme) var colorScheme
    var textString: String
    
    private func makeLinkedText(_ textString: String) -> NSAttributedString {
        let result = NSMutableAttributedString(string: textString)
        
        let textLength = textString.utf16.count
        let textRange = NSRange(location: 0, length: textLength)
        let tuple = ElementsBuilder.createElements(types: [LinkType.hashtag, LinkType.mention, LinkType.url], from: textString, range: textRange)
        
        result.addAttribute(.font,
                            value: UIFont.preferredFont(forTextStyle: .body),
                            range: textRange)
        result.addAttribute(.foregroundColor,
                            value: colorScheme == .dark ? UIColor.white : UIColor.black,
                            range: textRange)
        
        for t in tuple {
            switch t.type {
            case .mention:
                result.addAttributes([.link: getUrl(with:"\(twitterURLString)/\(t.text)")], range: t.range)
            case .hashtag:
                result.addAttributes([.link: getUrl(with:"\(twitterURLString)/hashtag/\(t.text)?src=hashtag_click")], range: t.range)
            case .url:
                result.addAttributes([.link: getUrl(with:t.text)], range: t.range)
            }
        }
        
        
        return result
    }
    
    var body: some View {
        AttributedText(makeLinkedText(textString))
    }
    
    func getUrl(with urlString: String) -> URL {
        guard let url = URL(string: urlString) else {
            return twitterURL
        }
        return url
    }
}

struct TweetTextView_Previews: PreviewProvider {
    static var previews: some View {
        TweetTextView(textString: tweetText)
            .previewLayout(.fixed(width: 300, height: 350))
    }
}
