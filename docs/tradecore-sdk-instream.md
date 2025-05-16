# Instream Integration Guide

The `TradecoreInstreamVideo` is the main object to integrate the in-stream ads.  

## Intitialization

At the first step, you should initialize the `TradecoreInstreamVideo` object in the following way: 

``` swift
let instreamVideo = TradecoreInstreamVideo(zoneId: String, player: AVPlayer, delegate: TradecoreInstreamVideoDelegate?)
``` 

- `zoneID` - the identifier provided by the TradeCore platform
- `player` - the video player that shows the app content
- `delegate` - the instance of a class that will manage the lifecycle events of the instream ad. 


## Load Ad

To start the ad loading process, you should call the `loadAd()` method of the `TradecoreInstreamVideo `: 

``` swift
instreamVideo.loadAd()
```


## Subscribe to the ad events

To subscribe to the ad and playback events, you should implement `TradecoreInstreamVideoDelegate` in your code. 


```
 func instreamVideo(_ instreamVideo: TradecoreInstreamVideo!, adLoadedWith adData: TradecoreInstreamAdData!) {

  }
```

```
  func instreamVideo(_ instreamVideo: TradecoreInstreamVideo!, failedWith adErrorData: TradecoreLoadAdError!) {
}
```