# Tradecore iOS SDK - Instream - Bidding Only

In bidding-only mode, the Tradecore SDK handles the bidding process and returns the relevant targeting keywords.

To integrate Instream in this mode, create an instance of the `TradecoreInstreamVideo` class, configure it with respective zone ID and delgate, and call its `load()` method.

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

## Ad events

By utilizing the `TradecoreInstreamVideoDelegate` protocol, you gain the ability to observe and respond to various ad lifecycle events. 

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

You can access the received targeting keywords by using [`TradecoreAd`](./tradecore-sdk-ad-metadata.md) parameter.