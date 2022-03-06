//
//  StaticData.swift
//  
//
//  Created by Galina on 26/02/2022.
//

import Foundation

public let twitterURLString = "https://twitter.com"
public let twitterURL = URL(string: twitterURLString)!

// MARK: - Static data for API V1

let staticUser = User(
    id: "1234567890",
    name: "User Name",
    screenName: "UserName",
    profileImageURLHTTPs: "https://uSeRnAME")

let staticUser2 = User(
    id: "1234567892",
    name: "User Name 2",
    screenName: "UserName2",
    profileImageURLHTTPs: "https://uSeRnAME2")


let staticMediaPhoto = Media(id: "1",
                               mediaUrlHttps: "https://dummyimage.com/hd720",
                               type: "photo",
                               videoInfo: nil)


let staticEntities = Entities(hashtags: nil, media: [staticMediaPhoto], userMentions: nil, urls: nil)

let tweetText = """
    Lorem #ipsum dolor sit amet, consectetur adipiscing #elit8.
    Donec @tempus25 urna a diam maximus, eu @lobortis tortor https://facilisis.com
    Vivamus accumsan lorem vel tortor @aliqu_am porttitor.
    Class aptent taciti sociosqu #nostra_car, per inceptos himenaeos.
"""

let staticTwitter = Twitter(
    id: "0123545678912345678",
    createdAt: "Sun May 13 12:41:16 +0000 2018",
    text: tweetText,
    retweetedStatus: nil,
    entities: staticEntities,
    quotedStatus: nil,
    user: staticUser,
    retweet: 1,
    favorite: 2)

let staticRTTwitter = Twitter(
    id: "0123545678912345678",
    createdAt: "Sun May 13 12:41:16 +0000 2018",
    text: "RT \(tweetText)",
    retweetedStatus: staticTwitter,
    entities: nil,
    quotedStatus: nil,
    user: staticUser2,
    retweet: 1,
    favorite: 2)

let staticQuotedTwitter = Twitter(
    id: "0123545678912345678",
    createdAt: "Sun May 13 12:41:16 +0000 2018",
    text: "Quoted status text",
    retweetedStatus: nil,
    entities: nil,
    quotedStatus: staticTwitter,
    user: staticUser2,
    retweet: 1,
    favorite: 2)

// MARK: - Static data for API V2

let staticUserV2 = UserV2(id: "1234567892", name: "User Name 2", username: "UserName2", profileImageURL: "https://uSeRnAME2")
let referencedTweetRT = ReferencedTweets(type: "retweeted", id: "0123545678912345678")
let referencedTweetQT = ReferencedTweets(type: "quoted", id: "0123545678912345678")
let publicMetrics = PublicMetrics(retweet: 1, reply: 2, like: 3, quote: 4)
let mediaKey = MediaV2(mediaKey: "7_1234567890123456789", height: 150, width: 150, type: "photo", url: "https://dummyimage.com/squarepopup", previewImageURL: "https://dummyimage.com/squarepopup")
let attachment = Attachments(mediaKeys: ["7_1234567890123456789"])

let staticTwitterV2 = TwitterData(
    id: "0123545678912345678",
    authorID: "123456789012131415",
    createdAt: "Sun May 13 12:41:16 +0000 2018",
    referencedTweets: nil,
    text: tweetText,
    possiblySensitive: false,
    publicMetrics: publicMetrics,
    attachments: attachment)

let staticRTTwitterV2 = TwitterData(
    id: "0123545678912345679",
    authorID: "123456789012131415",
    createdAt: "Sun May 13 12:41:16 +0000 2018",
    referencedTweets: [referencedTweetRT],
    text: "RT \(tweetText)",
    possiblySensitive: false,
    publicMetrics: publicMetrics,
    attachments: nil)

let staticQuotedTwitterV2 = TwitterData(
    id: "0123545678912345670",
    authorID: "123456789012131415",
    createdAt: "Sun May 13 12:41:16 +0000 2018",
    referencedTweets: [referencedTweetQT],
    text: "Quoted status text",
    possiblySensitive: false,
    publicMetrics: publicMetrics,
    attachments: nil)

let includes = TwitterIncludes(tweets: [staticTwitterV2], users: [staticUserV2], media: [mediaKey])

let staticTweetsV2 = TwitterV2(data: [staticTwitterV2, staticRTTwitterV2, staticQuotedTwitterV2], includes: includes)
