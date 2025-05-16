# Tradecore iOS SDK - Integration


The `TradecoreSDK` is an SDK Manager class, a singleton instance that exists in the global context and provides common services for the user s.a.:

- remote configuration loading, refreshing it at runtime;
- general targeting properties;
- custom analytics tracking;


## Integrate SDK into the project

Tradecore SDK is available via CocoaPods dependency manager. 


The Tradecore SDK consists of several modules that allow seamless combination of a monetization stack for individual publishers. If you need to integrate the full monetization stack (Prebid + Amazon + GAM), just add the following dependency to the `Podfile`: 


```
// TODO
```

If you need the custom monetization stack, you should integrate the Tradecore SDK Core and the needed Tradecore SDK plugins as separate dependencies: 

```
// TODO
```

## Initializtion

For the proper SDK work, you should initialize it on the app launch, providing the specific StackID. 

``` swift
TradecoreSDK.initialize(stackID: String)
```


You need only the `stackID` parameter to initialize the SDK according to your needs. All other configuration details will be downloaded from the Trade House platform and applied automatically.  


## Utilities

Despite the fact that the whole SDK configuration is provided via remote config settings, the TradecoreSDK provides an additional API to change and customize the SDK behaviour and change targeting/configuration params for each particular 

### SDK Version

To get the SDK version, use the following read-only property: 

```
TradecoreSDK.version
```

### SDK Log Level

The Tradecore SDK allows you  appto customize the logs verbose level. Use the following property to reduce log messages to the most critical ones or vice versa, to log as much as possible: 

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


