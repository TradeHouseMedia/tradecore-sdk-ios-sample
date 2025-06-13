//
//  HTMLAdViewController.m
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import "HTMLAdViewController.h"

@interface HTMLAdViewController() <TradecoreAdViewDelegate>

@property (strong, nullable) TradecoreAdView *tradecoreAdView;

@end

@implementation HTMLAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createAd];
}

- (void)createAd {
    // 1. Create TradecoreAdView instance.
    TradecoreAdView * tradecoreAdView = [
        [TradecoreAdView alloc]
        initWithZoneId:@"tradecore-zone-3492"
        delegate:self
    ];
    
    // 2. Set root view controller that is used by the ad view to present full screen
    // content after the user interacts with the ad.
    tradecoreAdView.rootViewController = self;
    
    // 3. Set zone-specific parameters if needed.
    TradecoreGAMZoneRequestParameters * parameters = [
        [TradecoreGAMZoneRequestParameters alloc]
        initWithCustomTargeting:@{@"sample": @"1"}
        categoryExclusions:@[@"sample"]
        keywords:@[@"Sample"]
        contentURL:@"https://sample.com/"
        publisherProvidedID:@"Sample"
        extrasParameters:@{@"sample": @1}
    ];
    
    tradecoreAdView.requestParameters = @[parameters];
    
    // 4. Add view to UI.
    [self.containerView addSubview:tradecoreAdView];
    
    // 5. Store `TradecoreAdView` instance.
    self.tradecoreAdView = tradecoreAdView;
    
    // 6. Load the ad.
    [tradecoreAdView load];
}

- (void)onReloadTapped:(UIButton *)sender {
    [super onReloadTapped:sender];
    
    [self.tradecoreAdView removeFromSuperview];
    self.tradecoreAdView = nil;
    [self createAd];
}

// MARK: - TradecoreAdViewDelegate

- (void)tradecoreAdDidLoadWithAd:(TradecoreAd *)ad {
    NSLog(@"Ad successfully loaded.");
    [self.reloadButton setEnabled:true];
}

- (void)tradecoreAdDidFailToLoadWithError:(NSError *)error {
    NSLog(@"Ad failed to load: %@", error.localizedDescription);
    [self.reloadButton setEnabled:true];
}

- (void)tradecoreAdDidReportClickWithAd:(TradecoreAd *)ad {
    NSLog(@"Ad was clicked.");
}

- (void)tradecoreAdDidReportImpressionWithAd:(TradecoreAd *)ad {
    NSLog(@"Ad impression reported.");
}

- (void)tradecoreAdWillPresentScreenWithAd:(TradecoreAd *)ad {
    NSLog(@"Ad will present modal view controller.");
}

- (void)tradecoreAdWillDismissScreenWithAd:(TradecoreAd *)ad {
    NSLog(@"Ad will dismiss modal view controller.");
}

- (void)tradecoreAdDidDismissScreenWithAd:(TradecoreAd *)ad {
    NSLog(@"Ad did dismiss modal view controller.");
}

@end
