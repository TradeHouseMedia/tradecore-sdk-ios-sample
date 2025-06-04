# Tradecore iOS SDK - Instream - Rendering

In rendering mode, Tradecore SDK manages Google Interactive Media Ads SDK internally. 

To integrate Instream in this mode, instantiate the `TradecoreInstreamVideo` class and configure it with the appropriate zone ID and delegate. Additionally, set the corresponding player, container view, and view controller and then invoke the `load()` method.

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

## Ad events

By utilizing the `TradecoreInstreamVideoDelegate` protocol, you gain the ability to observe and respond to various ad lifecycle events. 

Ensure to call the `start()` method in order to start ad playback once the ad is loaded.

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

## TradecoreInstreamVideo Overview

Please refer to the table below for a detailed overview of the `TradecoreInstreamVideo` properties and methods available for configuration in rendering mode.

| Property/Methods      | Description        |
|-----------------------|--------------------|
| `start`   | Used to start the ad playback. |
| `pause`   | Used to pause the ad playback. |
| `resume`  | Used to resume the ad playback.|
| `skip`    | Used to skip the ad playback.  |
