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
    TradecoreGAMStackRequestParameters *parameters = [[TradecoreGAMStackRequestParameters alloc] initWithTestDeviceIdentifiers:@[@"00000000-0000000000000000"]];
    [TradecoreSDK shared].requestParameters = @[parameters];
    
    // Initialize Tradecore SDK with the respective Stack ID and Itunes ID.
    [TradecoreSDK.shared initializeWith:@"tradecore-stack-69" itunesId:@"123456789"];
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {}
@end
