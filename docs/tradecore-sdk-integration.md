# Tradecore iOS SDK - Integration


The `TradecoreSDK` is an SDK Manager class, a singleton instance that exists in the global context and provides common services for the user s.a.:

- remote configuration loading, refreshing it in runtime
- common targeting
- custom analytics tracking
- factories for various objects if needed
- There should be an Internal global object counterpart that will be used by Tradecore ad view object instances. 

## Integrate SDK into the project

Tradecore SDK is available via CooaPods dependency manager. 

```
// TODO
```

## Initializtion


## Configuration 

## Utilities 

API
Description
TradecoreSDK
an SDK manager class
.shared
a class read-only property - the singleton instance of the SDK
.version
a class read-only property - the SDK version string
.logLevel
an instance property to set a log level to one of [.debug, .error, .off]
.loadStack(id: String)
an instance method - the primary way to initialize the configuration in runtime. takes the publisher's stack ID as a parameter.  2 open questions: 
do we allow to reload stack in runtime, or each app will not have to dynamically change stack in runtime.
do we need any level of protection to fetch configuration s.a. secret key-based signatures so the publisher only can fetch their own stack
.setTargeting(targeting: [TradecoreTargeting])
an instance method to send any first party data for every Tradecore zone. Takes a list of  TradecoreTargeting-inherited objects.  TradecoreTargeting is an abstract base class for: PrebidTargeting, GAMTargeting, APSTargeting (later more may be added). The specific implementations are needed as FPD may be represented differently for PBS, APS or GAM. 


