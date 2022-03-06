//
//  String.swift
//  
//
//  Created by Galina on 26/02/2022.
//

import Foundation

extension String {
    func toDateString(locale: String) -> String {
        let formatter = DateFormatter()
        
        let version = UserDefaults.standard.string(forKey: TwitterAPIVersionKey)
        if version == "v2" {
            // V2 "2022-03-04T14:20:17.000Z"
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        } else {
            // V1 "Thu Mar 03 14:20:17 +0000 2022"
            formatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
        }
        
        formatter.locale = Locale(identifier: "en")
        
        let date = formatter.date(from: self) ?? Date()
        
        // "jeu. 03 mars 2022" / fr_FR_POSIX
        formatter.dateFormat = "E dd MMM yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: locale)

        let str = formatter.string(from: date)

        return str
    }
    
    func trim(to maximumCharacters: Int) -> String {
        return "\(self[..<index(startIndex, offsetBy: maximumCharacters)])" + "..."
    }
}
