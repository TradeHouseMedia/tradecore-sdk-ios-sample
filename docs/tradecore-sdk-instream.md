# Tradecore iOS SDK - Instream Integration Guide

To load the instream video ad, create a `TradecoreInstreamVideo` object, configure it, and call its `load()` method.

There are two possible scenarios of `TradecoreInstreamVideo` usage: 

1. Tradecore SDK receives the player, container view and view controller, and manages Google Interactive Media Ads SDK internally. 

```swift 
private var tradecoreInstreamVideo: TradecoreInstreamVideo?

func createAd() {
    // 1. Create `TradecoreInstreamVideo`
    let instreamVideo = TradecoreInstreamVideo(
        zoneId: ZONE_ID,
        player: contentPlayer,
        adContainer: containerView,
        adContainerViewController: self,
        delegate: self
    )
    
    // 2. Store `TradecoreInstreamVideo`
    tradecoreInstreamVideo = instreamVideo
    
    // 3. Load the ad
    tradecoreInstreamVideo?.load()
}
```

By utilizing the `TradecoreInstreamVideoDelegate` protocol, you gain the ability to observe and respond to various ad lifecycle events. 

Make sure to call the `start()` method in order to start ad playback once the ad is loaded.

```swift
// MARK: TradecoreInstreamVideoDelegate
extension MyViewController: TradecoreInstreamVideoDelegate {
    
    func tradecoreAdDidLoad(ad: TradecoreAd) {
        // Ad is loaded.
        // Start the ad playback.
        tradecoreInstreamVideo?.start()
    }
    
    func tradecoreAdDidFailToLoad(error: any Error) {
        // Ad did fail to load.
    }
    
    func tradecoreAdDidPausePlayback(ad: TradecoreAd) {
        // Called when an ad is ready to play.
    }
    
    func tradecoreAdDidResumePlayback(ad: TradecoreAd) {
        // Called when an ad has finished or an error occurred during the playback.
    }
    
    func tradecoreIMADidReceiveEvent(ad: TradecoreAd, event: NSObject) {
        // Called when Google IMA SDK receives `IMAAdEvent`.
        // Import Google IMA SDK and downcast `event` to `IMAAdEvent` to get more information.
    }
}
```

Most of the delegate methods provide a parameter containing metadata about the loaded ad. You can find detailed information about the ad metadata structure and its fields in the [Ad Metadata](./tradecore-sdk-ad-metadata.md) section.

2. Tradecore SDK performs bidding only and returns the corresponding targeting keywords.

```swift
private var tradecoreInstreamVideo: TradecoreInstreamVideo?

func createAd() {
    // 1. Create TradecoreInstreamVideo
    let instreamVideo = TradecoreInstreamVideo(
        zoneId: ZONE_ID,
        delegate: self
    )
    
    // 2. Store `TradecoreInstreamVideo`
    tradecoreInstreamVideo = instreamVideo
    
    // 3. Load the ad
    tradecoreInstreamVideo?.load()
}
```

**NOTE**: In this scenario, only the following two delegate methods are called:

```swift
// MARK: TradecoreInstreamVideoDelegate
extension MyViewController: TradecoreInstreamVideoDelegate {
    
    func tradecoreAdDidLoad(ad: TradecoreAd) {
        // Ad is loaded.
        print(ad.pbsTargeting)
    }
    
    func tradecoreAdDidFailToLoad(error: any Error) {
        // Ad did fail to load.
    }
}
```

You can access the received targeting keywords using [`TradecoreAd`](./tradecore-sdk-ad-metadata.md) parameter.

## TradecoreInstreamVideo Overview

Refer to the table below for a breakdown of the `TradecoreInstreamVideo` properties and methods you can use for configuration.

| Property/Methods      | Description        |
|-----------------------|--------------------|
| `start`   | Used to start the ad playback. |
| `pause`   | Used to pause the ad playback. |
| `resume`  | Used to resume the ad playback.|
| `skip`    | Used to skip the ad playback.  |
