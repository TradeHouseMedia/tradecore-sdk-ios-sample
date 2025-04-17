# Tradecore iOS SDK - Integration


The `TradecoreSDK` is an SDK Manager class, a singleton instance that exists in the global context and provides common services for the user s.a.:

- remote configuration loading, refreshing it in runtime
- common targeting
- custom analytics tracking
- factories for various objects if needed
- There should be an Internal global object counterpart that will be used by Tradecore ad view object instances. 

## Integrate SDK into the project

Tradecore SDK is available via CocoaPods dependency manager. 

```
// TODO
```

## Initializtion

For the proper SDK work, you should initialize it on the app launch, providing the specific StackID. 

``` swift
TradecoreSDK.initialize(stackID: String)
```


The `initialize()` is the primary way to initialize SDK with a specific configuration in runtime. takes the publisher's stack ID as a parameter. 



## Utilities 

### SDK Version

To get the SDK version, use the following read-only property: 

```
TradecoreSDK.version
```

### SDK Log Level

The Tradecore SDK allows you to customize the logs verbose level. Use the following property to reduce log messages to the most critical ones or vice versa, to log as much as possible: 

``` swift
TradecoreSDK.logLevel
```

The supported levels are: 

``` swift 
[.debug, .error, .off]
```


### Custom Targeting

The TradecoreSDK allows sending platform-specific targeting keywords using the following method: 

``` swift
TradecoreSDK.setTargeting(targeting: [TradecoreTargeting])
```


This method accepts the list of platform-specific targeting objects inferred from `TradecoreTargeting`. 

#### Prebid Targeting

// TODO

#### Amazon Targeting

// TODO

#### Google Ad Manager Targeting

// TODO


