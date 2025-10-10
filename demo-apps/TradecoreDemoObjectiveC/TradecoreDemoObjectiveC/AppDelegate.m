//
//  AppDelegate.m
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initializeTradecore];
    return YES;
}

- (void)initializeTradecore {
    // Set debugMode if needed.
    TradecoreSDK.shared.debugMode = true;
    
    // Set global request parameters if needed.
    TradecoreGAMStackRequestParameters *gamParameters = [[TradecoreGAMStackRequestParameters alloc] initWithTestDeviceIdentifiers:@[@"00000000-0000000000000000"]];
    
    NSString * prebidAppConfig = @"{\
        \"name\": \"Tradecore DemoAppObjectiveC\",\
        \"cat\": [\"IAB1\", \"IAB9-9\"],\
        \"keywords\": \"testing,demo\",\
        \"publisher\": {\
            \"cat\": [\"IAB9\", \"IAB9-30\"]\
        }\
    }";
    
    TradecorePrebidStackRequestParameters *prebidParameters = [[TradecorePrebidStackRequestParameters alloc] initWithAppConfig:prebidAppConfig];
    
    [TradecoreSDK shared].requestParameters = @[gamParameters, prebidParameters];
    
    // Initialize Tradecore SDK with the respective Stack ID and Itunes ID.
    [TradecoreSDK.shared initializeWith:@"tradecore-stack-69" itunesId:@"123456789" completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Tradecore SDK failed to initialize with error: %@", error.localizedDescription);
            return;
        }
        
        // Tradecore SDK is ready to load the ads.
    }];
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {}
@end
