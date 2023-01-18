# TweetieFeed

[![Swift 5.3](https://img.shields.io/badge/swift-5.3-green.svg?longCache=true&style=flat-square)](https://developer.apple.com/swift)
[![Platforms](https://img.shields.io/badge/platform-iOS-blue.svg?longCache=true&style=flat-square)](https://www.apple.com)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?longCache=true&style=flat-square)](https://en.wikipedia.org/wiki/MIT_License)

**Twitter feeds for SwiftUI**

Supports:

* Twitter API v1.1 and v2
* iOS 14+
* Xcode 13+

<p align="center">
<img src="Screenshots/tweetTwitter.jpg" width="250"/>
<img src="Screenshots/tweetGitHub.jpg" width="250"/>
<img src="Screenshots/quoted.jpg" width="250"/>
</p>

## Installation

Add the package to `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/ugalek/TweetieFeed.git", from: "0.2.0")
]
```

## Usage

Import `TweetieFeed`:

```swift
import TweetieFeed
```

In your `App` struct, initialize a `TweetieFeedUISettings` instance as `StateObject`, then give this instance to `environmentObject`:

```swift
struct MyApp: App {
    @StateObject var uiSettings = TweetieFeedUISettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ExampleViewModel())
                .environmentObject(uiSettings)
        }
    }
}

```

`TweetieFeedUISettings` takes the following optional parameters to customize the view:

Parameter                  | Description
---------------------------|------------------------------------------------------------------------
`backgroundDark`           | Color change background color UI at the dark mode
`backgroundLight`          | Color change background color UI at the light mode
`tweetBackgroundDark`      | Color change tweet background at the dark mode
`tweetBackgroundLight`     | Color change tweet background at the light mode
`tweetBorderDark`          | Color change tweet border at the dark mode
`tweetBorderLight`         | Color change tweet border at the light mode
`retweetedStatusTextColor` | Color.secondary by default: change retweeted status text
`footerTextColor`          | Color.gray by default: change text in the footer *(retweet & favorite)*
`tweetBodyCornerRadius`    | CGFloat 15 by default: change corner radius tweet card
`localeIdentifier`         | String by default "en_US": change locale to display the date
`listStyle`                | The style of the `List`. Defaults to `.plainListStyle`


In your view model, use `TweetieFeedDecoder` to decode the data according the API version:

```swift
class YourViewModel: ObservableObject {
    var feedDecoder: TweetieFeedDecoder?
    
    init(feedDecoder: TweetieFeedDecoder? = nil) {
        self.feedDecoder = feedDecoder
    }
    
    func getData(version: TwitterAPIVersion = .v1) {
        // Fetch Twitter API data here
        ...
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            DispatchQueue.main.async {
                self.feedDecoder = TweetieFeedDecoder(data: data, version: version)
            }
        }
        task.resume()
        ...
    }
}
```

In your SwiftUI view, declare a `TweetieFeedView` with the `TweetieFeedDecoder` instance created before:

```swift
VStack {
    ...
    TweetieFeedView(tweetieDecoder: viewModel.feedDecoder)
    ...
}
.onAppear {
    viewModel.getData()
}
```

**Don't forget to add the `onAppear` modifier that calls the view model method that handles data fetching and decoding**.

You can find an example in the `Example` folder.

## Twitter API fields (required / recommended)

### v1.1

`tweet_mode=extended` is **required**.

### v2

**These fields are recommended for best display but not required.**

`expansions`:

* `attachments.media_keys`
* `author_id` is **required**
* `entities.mentions.username`
* `in_reply_to_user_id`
* `referenced_tweets.id `

`tweet.fields`:

* `attachments`
* `author_id`
* `created_at` is **required**
* `entities`
* `id`
* `in_reply_to_user_id`
* `possibly_sensitive`
* `public_metrics`
* `reply_settings`
* `text`

`user.fields`:

* `created_at`
* `description`
* `entities`
* `id`
* `name`
* `profile_image_url`
* `username`

`media.fields`:

* `heigh`
* `media_key`
* `preview_image_url`
* `type`
* `url`
* `width`


<a href="https://www.buymeacoffee.com/ugalek" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-blue.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

## License

TweetieFeed is under MIT license. See the LICENSE file for more info.
