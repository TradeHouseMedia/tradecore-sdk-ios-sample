# Tradecore iOS SDK - Integration

## Cocoapods

We assume the [Cocoapods](cocoapods.org) dependency manager is already integrated into the project. If not follow the **Get Started** instructions on [cocoapods.org](cocoapods.org). 

Add this line into your Podfile within the application target:

```ruby
pod 'Tradecore'
```

Additionally, add a respective dependency for each monetization platform you use the app:

- Amazon Publishing Service SDK:

```ruby
pod 'TradecoreAmazon'
```

- Prebid Mobile:

```ruby
pod 'TradecorePrebid'
```

- Google Ad Manager:

```ruby
pod 'TradecoreGoogleMobileAds'
```

- Google Interactive Media Ads:

```ruby
pod 'TradecoreGoogleInteractiveMediaAds'
```

**NOTE:** If your project uses PrebidMobile version 3.0.0 or earlier, you should include a `post_install` block in your Podfile to ensure proper integration.
```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'PrebidMobile'
      target.build_configurations.each do |config|
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      end
    end
  end
end
```

If the application has dependencies on Prebid, Amazon, or Google SDKs, you should remove them. Tradecore modules will integrate them automatically. 

Then install the dependencies run the following command:

```ruby
pod install --repo-update
```
