//
//  InstreamVideoIMAViewController.m
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import "InstreamVideoIMAViewController.h"

@interface InstreamVideoIMAViewController () <TradecoreInstreamVideoDelegate, IMAAdsLoaderDelegate, IMAAdsManagerDelegate>

@property (strong) AVPlayer *contentPlayer;
@property (strong) AVPlayerLayer *playerLayer;

// GIMA SDK
@property (strong, nullable) IMAAdsLoader *adsLoader;
@property (strong, nullable) IMAAVPlayerContentPlayhead *contentPlayhead;
@property (strong, nullable) IMAAdsManager *adsManager;

// Tradecore SDK
@property (strong, nullable) TradecoreInstreamVideo *tradecoreInstreamVideo;

@end

@implementation InstreamVideoIMAViewController

- (NSURL *)videoContentURL {
    return [NSURL URLWithString:@"https://storage.googleapis.com/gvabox/media/samples/stock.mp4"];
}

- (NSString *)baseAdTagURL {
    return @"https://pubads.g.doubleclick.net/gampad/ads?output=xml_vast4&unviewed_position_start=1&gdfp_req=1&env=vp&sz=300x250&iu=/22786333977/ca-video-pub-6078204731134206-tag/ROS_player";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentPlayer = [AVPlayer playerWithURL:self.videoContentURL];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.contentPlayer];
    self.playerLayer.frame = self.containerView.layer.bounds;
    [self.containerView.layer addSublayer:self.playerLayer];
    
    self.contentPlayhead = [[IMAAVPlayerContentPlayhead alloc] initWithAVPlayer:self.contentPlayer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.contentPlayer pause];
}

- (void)createAd {
    // 1. Create TradecoreInstreamVideo
    TradecoreInstreamVideo * instreamVideo = [
        [TradecoreInstreamVideo alloc]
        initWithZoneId:@"tradecore-zone-3495"
        delegate:self
    ];
    
    // 2. Store the `TradecoreInstreamVideo`
    self.tradecoreInstreamVideo = instreamVideo;
    
    // 3. Load the ad
    [instreamVideo load];
}

- (void)onPlayTapped:(id)sender {
    [super onPlayTapped:sender];
    [self createAd];
}

- (void)onReloadTapped:(id)sender {
    [super onReloadTapped:sender];
    
    [self.adsManager destroy];
    
    // Reset TradecoreInstreamVideo
    self.tradecoreInstreamVideo = nil;
    
    // Reset player
    [self.contentPlayer pause];
    [self.contentPlayer seekToTime:kCMTimeZero];
    [self.playButton setHidden:false];
}

// MARK: - Ad Tag URL Generation

- (NSString *)generateInstreamUriForGAMWithCustomKeywords:(NSDictionary<NSString *, NSString *> *)customKeywords {
    if (!customKeywords || customKeywords.count == 0) {
        return self.baseAdTagURL;
    }
    
    NSMutableArray<NSString *> *components = [NSMutableArray array];
    [customKeywords enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
        [components addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }];
    
    NSString *joined = [components componentsJoinedByString:@"&"];
    NSCharacterSet *allowedSet = [[NSCharacterSet characterSetWithCharactersInString:@"&=\"#%/<>?@\\^`{|}"] invertedSet];
    NSString *escaped = [joined stringByAddingPercentEncodingWithAllowedCharacters:allowedSet];
    
    NSString *queryStringKeywords = [NSString stringWithFormat:@"cust_params=%@", escaped ?: @""];
    return [NSString stringWithFormat:@"%@&%@", self.baseAdTagURL, queryStringKeywords];
}

// MARK: - TradecoreInstreamVideoDelegate

- (void)tradecoreAdDidLoadWithAd:(TradecoreAd *)ad {
    NSLog(@"Ad successfully loaded.");
    [self.reloadButton setEnabled:true];
    
    // 3. Generate GAM Instream URI
    NSString * adTagURLString = [self generateInstreamUriForGAMWithCustomKeywords:ad.pbsTargeting];
    
    if (adTagURLString == nil) {
        NSLog(@"App failed to generate ad tag URL.");
        [self.contentPlayer play];
        return;
    }
    
    NSLog(@"App generated ad tag URL: %@", adTagURLString);
    
    // 4. Create IMAAdDisplayContainer
    IMAAdDisplayContainer * adDisplayContainer = [
        [IMAAdDisplayContainer alloc]
        initWithAdContainer:self.containerView
        viewController:self
    ];
    
    // 5. Create IMAAdsRequest
    IMAAdsRequest * request = [
        [IMAAdsRequest alloc]
        initWithAdTagUrl:adTagURLString
        adDisplayContainer:adDisplayContainer
        contentPlayhead:self.contentPlayhead
        userContext:nil
    ];
    
    // 6. Create IMAAdsLoader
    self.adsLoader = [IMAAdsLoader new];
    self.adsLoader.delegate = self;
    
    // 7. Load IMA ad request
    [self.adsLoader requestAdsWithRequest:request];
}

- (void)tradecoreAdDidFailToLoadWithError:(NSError *)error {
    NSLog(@"Ad failed to load: %@", error.localizedDescription);
    [self.reloadButton setEnabled:true];
    
    [self.contentPlayer play];
}

// MARK: - IMAAdsLoaderDelegate

- (void)adsLoader:(IMAAdsLoader *)loader adsLoadedWithData:(IMAAdsLoadedData *)adsLoadedData {
    // 8. Grab the instance of the IMAAdsManager and set ourselves as the delegate.
    self.adsManager = adsLoadedData.adsManager;
    self.adsManager.delegate = self;
    
    // 9. Initialize the ads manager.
    [self.adsManager initializeWithAdsRenderingSettings:nil];
}

- (void)adsLoader:(IMAAdsLoader *)loader failedWithErrorData:(IMAAdLoadingErrorData *)adErrorData {
    NSLog(@"Google IMA SDK failed to load an ad: %@", adErrorData.adError.message);
    [self.contentPlayer play];
}

// MARK: - IMAAdsManagerDelegate

- (void)adsManager:(IMAAdsManager *)adsManager didReceiveAdEvent:(IMAAdEvent *)event {
    // 10. When the SDK notifies us that ads have been loaded, play them.
    if (event.type == kIMAAdEvent_LOADED) {
        [self.adsManager start];
    }
}

- (void)adsManager:(IMAAdsManager *)adsManager didReceiveAdError:(IMAAdError *)error {
    NSLog(@"Google IMA SDK failed to load an ad: %@", error.message);
    [self.contentPlayer play];
}

- (void)adsManagerDidRequestContentPause:(IMAAdsManager *)adsManager {
    // 11. The Google IMA SDK is going to play ads, so pause the content.
    [self.contentPlayer pause];
}

- (void)adsManagerDidRequestContentResume:(IMAAdsManager *)adsManager {
    // 12. The Google IMA SDK is done playing ads (at least for now), so resume the content.
    [self.contentPlayer play];
}

@end
