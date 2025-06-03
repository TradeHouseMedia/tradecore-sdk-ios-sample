# Tradecore iOS SDK - Request Parameters

Request parameters come in two types: stack-level and zone-specific.

## Stack Parameters

Stack parameters are global settings that apply universally across the SDK, affecting all zones(placements) within the stack.

### GAM

The `TradecoreGAMStackRequestParameters` class is designed to manage Google Ad Manager (GAM) configuration for the entire stack. Below is overview of its properties:

| Property               | Description                                               |
|------------------------|-----------------------------------------------------------|
| `testDeviceIdentifiers`| Array of test device IDs that always request test ads.  |

Example of usage:

```swift
// Create `TradecoreGAMStackRequestParameters` instance
let gamParameters = TradecoreGAMStackRequestParameters()
gamParameters.testDeviceIdentifiers = ["0000000-000000000000"]

// Set global request parameters
TradecoreSDK.shared.requestParameters = [gamParameters]
```

## Zone Parameters

Zone parameters are settings unique to each placement or zone, enabling tailored configurations for each ad requests.

### GAM

The `TradecoreZoneRequestParameters` class should be used to configure Google Ad Manager (GAM) settings at the zone level.

| Property               | Description                                                                                              |
|------------------------|----------------------------------------------------------------------------------------------------------|
| `customTargeting`      | Key-value pairs used for custom targeting in ad requests.                                                |
| `categoryExclusions`   | Array of categories to exclude from ad results.                                                          |
| `keywords`             | Array of keywords describing current user activity (e.g., "Sports Scores" or "Football"). Set to nil to clear keywords. |
| `contentURL`           | URL of a webpage matching the app’s primary content, used for targeting and brand safety purposes.       |
| `publisherProvidedID`  | User ID provided by the publisher for targeting purposes.                                                |
| `extrasParameters`     | Additional ad network parameters sent to Google networks.                                                |

Example of usage:

```swift
let tradecoreAdView = TradecoreAdView(zoneId: ZONE_ID, delegate: self)

// Create `TradecoreGAMZoneRequestParameters` instance
let parameters = TradecoreGAMZoneRequestParameters()
parameters.customTargeting = ["sample": "1"]
parameters.categoryExclusions = ["sample"]
parameters.keywords = ["Sample"]
parameters.contentURL = "https://sample.com/"
parameters.publisherProvidedID = "Sample"
parameters.extrasParameters = ["sample": 1]

// Set parameters in respective ad view
tradecoreAdView.requestParameters = [parameters]
```