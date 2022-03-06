import XCTest
@testable import TweetieFeed

final class TweetieFeedTests: XCTestCase {
    
    let jsonV1 = """
[
    {
        "created_at": "Thu Mar 03 14:20:05 +0000 2022",
        "id": 1234567890123456789,
        "id_str": "1234567890123456789",
        "full_text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
        "truncated": false,
        "entities": {
            "hashtags": [],
            "symbols": [],
            "user_mentions": [],
            "urls": []
        },
        "user": {
            "id": 776655443322110099,
            "id_str": "776655443322110099",
            "name": "User",
            "screen_name": "user",
            "description": "Description about user",
            "created_at": "Tue Jun 28 20:21:24 +0000 2016",
            "profile_image_url_https": "https://dummyimage.com/squarepopup"
        },
        "is_quote_status": false,
        "retweet_count": 0,
        "favorite_count": 0,
        "favorited": false,
        "retweeted": false
    }
]
"""
    
    let jsonV2 = """
{
    "data": [
        {
            "reply_settings": "everyone",
            "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
            "author_id": "776655443322110099",
            "id": "1234567890123456789",
            "created_at": "2022-03-03T14:20:05.000Z",
            "public_metrics": {
                "retweet_count": 0,
                "reply_count": 0,
                "like_count": 0,
                "quote_count": 1
            },
            "possibly_sensitive": false
        }
    ],
    "includes": {
        "users": [
            {
                "id": "776655443322110099",
                "username": "user",
                "name": "User",
                "created_at": "2016-06-28T20:21:24.000Z",
                "description": "Description about user",
                "profile_image_url": "https://dummyimage.com/squarepopup"
            }
        ],
        "tweets": []
    }
}
"""
    
    func testTweetieFeedDecoder_decodeJSON_v1() throws {
        let data = Data(jsonV1.utf8)
        
        let twitterFetcher = TweetieFeedDecoder(data: data, version: .v1)
        twitterFetcher.decode()
        
        let tweets = twitterFetcher.tweets
        XCTAssertNil(twitterFetcher.errorDescription)
        XCTAssertEqual(tweets.count, 1)
        XCTAssertEqual(tweets[0].id, "1234567890123456789")
    }
    
    func testTweetieFeedDecoder_decodeJSON_v1_withError() throws {
        let data = Data("".utf8)
        
        let twitterFetcher = TweetieFeedDecoder(data: data, version: .v1)
        twitterFetcher.decode()
        
        let tweets = twitterFetcher.tweets
        XCTAssertNotNil(twitterFetcher.errorDescription)
        XCTAssertEqual(tweets.count, 0)
    }
    
    func testTweetieFeedDecoder_decodeJSON_v2() throws {
        let data = Data(jsonV2.utf8)
        
        let twitterFetcher = TweetieFeedDecoder(data: data, version: .v2)
        twitterFetcher.decode()
        
        let tweets = twitterFetcher.tweets
        XCTAssertNil(twitterFetcher.errorDescription)
        XCTAssertEqual(tweets.count, 1)
        XCTAssertEqual(tweets[0].id, "1234567890123456789")
    }
    
    func testTweetieFeedDecoder_decodeJSON_v2_withError() throws {
        let data = Data("".utf8)
        
        let twitterFetcher = TweetieFeedDecoder(data: data, version: .v2)
        twitterFetcher.decode()
        
        let tweets = twitterFetcher.tweets
        XCTAssertNotNil(twitterFetcher.errorDescription)
        XCTAssertEqual(tweets.count, 0)
    }
    
    func testStringToDateExtension() throws {
        let dateV1 = "Mon Mar 07 14:20:17 +0000 2022"
        let dateV2 = "2022-03-07T14:20:17.000Z"
        
        UserDefaults.standard.set(TwitterAPIVersion.v1.rawValue, forKey: TwitterAPIVersionKey)
        let formatedDateV1 = dateV1.toDateString(locale: "fr_FR_POSIX")
        XCTAssertEqual(formatedDateV1, "lun. 07 mars 2022")
     
        UserDefaults.standard.set(TwitterAPIVersion.v2.rawValue, forKey: TwitterAPIVersionKey)
        let formatedDateV2 = dateV2.toDateString(locale: "fr_FR_POSIX")
        XCTAssertEqual(formatedDateV2, "lun. 07 mars 2022")
        
        let wrongDate = dateV1.toDateString(locale: "fr_FR_POSIX")
        let currentDare = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "E dd MMM yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "fr_FR_POSIX")
        
        XCTAssertNotEqual(wrongDate, "lun. 07 mars 2022")
        XCTAssertEqual(wrongDate, formatter.string(from: currentDare))
        
    }
}
