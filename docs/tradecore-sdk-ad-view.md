# Tradecore iOS SDK - Ad View Integration Guide

To load ad view, create a `TradecoreAdView` object, configure it, add it to the view hierarchy, and call its `load()` method.

*Swift*

```swift
private var tradecoreAdView: TradecoreAdView?
 
func createAd() {
    // 1. Create `TradecoreAdView`, set delegate.
    let tradecoreAdView = TradecoreAdView(zoneId: ZONE_ID, delegate: self)
    
    // 2. Set root view controller that is used by the ad view to present full screen
    // content after the user interacts with the ad.
    tradecoreAdView.rootViewController = self
    
    // 3. Add to UI
    containerView.addSubview(tradecoreAdView)
    
    // 4. Store the `TradecoreAdView`.
    self.tradecoreAdView = tradecoreAdView

    // 5. Load the ad
    tradecoreAdView.load()
}
```

The `TradecoreAdView` should be provided with the configuration properties:

- `zoneId` is the id used to obtain configuration from the global stack.
- `delegate` is optional parameter that signals about important lifecycle events.

## Ad events

By utilizing the `TradecoreAdViewDelegate` protocol, you gain the ability to observe and respond to various ad lifecycle events.

```swift
// MARK: - TradecoreAdViewDelegate
extension MyViewController: TradecoreAdViewDelegate {
    
    func tradecoreAdDidLoad(ad: TradecoreAd) {
        // Ad is loaded.
    }
    
    func tradecoreAdDidFailToLoad(error: any Error) {
        // Ad did fail to load.
    }
    
    func tradecoreAdWillPresentScreen(ad: TradecoreAd) {
        // Notifies delegate that the ad view will launch a modal.
    }
    
    func tradecoreAdWillDismissScreen(ad: TradecoreAd) {
        // Notifies delegate that the ad view is about to dismiss modal.
    }
    
    func tradecoreAdDidDismissScreen(ad: TradecoreAd) {
        // Notifies delegate that the ad view dismissed modal.
    }
    
    func tradecoreAdDidReportImpression(ad: TradecoreAd) {
        // Informs the delegate that an impression has occurred.
    }
    
    func tradecoreAdDidReportClick(ad: TradecoreAd) {
        // Notifies the delegate of the click event.
    }
}
```

Most of the delegate methods provide a parameter containing metadata about the loaded ad. You can find detailed information about the ad metadata structure and its fields in the [Ad Metadata](./tradecore-sdk-ad-metadata.md) section.

## TradecoreAdView Overview

Refer to the table below for a breakdown of the `TradecoreAdView` properties you can use for configuration.

| Property              | Description                                                                                                     |
|-----------------------|-----------------------------------------------------------------------------------------------------------------|
| `rootViewController`  | Reference to a root view controller used by the ad view to present full-screen content after user interaction.  |
| `requestParameters`   | Instance property to send first-party data for every Tradecore zone. See [Request Parameters](./tradecore-sdk-request-parameters.md#zone-parameters) section for more information.                                           |
| `adSize`              | Represents the size of the last loaded ad. Get-only property.                                                   |
