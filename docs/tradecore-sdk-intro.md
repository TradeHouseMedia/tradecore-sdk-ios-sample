# Tradecore iOS SDK - Introduction

## Integration

Follow the [integration instructions](./tradecore-sdk-integration.md) to add the SDK to your app.

## Tradecore SDK Configuration

### Initialization

Initialize Tradecore SDK in your `AppDelegate` instance's `application(:,didFinishLaunchingWithOptions:)` method. It is important to initialize the SDK once in the app lifetime prior to usage and ideally as early as possible.

```swift
import Tradecore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        TradecoreSDK.shared.initialize(with: STACK_ID, itunesId: ITUNES_ID)
        return true
    }
}
```

Parameters for the `.initialize` call:
- `stackId` is the identifier for the remote configuration of the app.
- `itunesId` is the iTunes identifier, typically used for referencing media or apps. 

### Additional SDK Configuration

Refer to the table below for a breakdown of the `TradecoreSDK` properties you can use for configuration.

| Property                               | Description                                                                                                            |
|----------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| `logLevel`                             | Controls the verbosity of the SDK logs.                                          |
| `debugMode`                            | Enables debug mode, which activates test mode in integrated ad SDKs and extra logging.                                 |
| `requestParameters`                    | Global request parameters, e.g., test device identifiers. For more information, see the [Request Parameters](./tradecore-sdk-request-parameters.md#stack-parameters) section. |
| `version`                              | Returns the current SDK version as a string.                                                                           |

## Ad Format Integration 

Tradecore SDK supports the following ad formats: 

- [Ad View](./tradecore-sdk-ad-view.md) (HTML)
- [Instream Video](./tradecore-sdk-instream) (Video)