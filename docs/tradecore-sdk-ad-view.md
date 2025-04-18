# Ad View Integration Guide

The `TradecoreAdView` is the main ad rendering object.  You should use it to integrate both the banner and video ads into the application layout. For the full screen ads - use `TradecoreInterstitialAd`. 

## Intitialization

At the first step, you should initialize the `TradecoreAdView` object with `zoneId` provided on the Tradecore platform: 

``` swift
let adView = TradecoreInterstitialAd(zoneID: YOUR_ZONE_ID, frame: frame)
``` 



## Load Ad

To start loading process you should call the `loadAd()` method of the `TradecoreAdView`: 

``` swift
adView.loadAd()
```


## Subscribe to the ad events

To subscribe to the ad view events, you should implement `TradecoreAdViewDelegate` in your code and register the implementation class in the `delegate` property of the `TradecoreAdView` object: 

``` swift
adView.delegate = self
```
