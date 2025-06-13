//
//  TestCasesManager.m
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import "TestCasesManager.h"
#import "AdFormat.h"

#import "HTMLAdViewController.h"
#import "InstreamVideoIMAViewController.h"

@implementation TestCasesManager

+ (NSArray<TestCase *> *)allCases {
    return @[
        [
            [TestCase alloc]
            initWithTitle:@"HTML Ad View (Prebid + Amazon + GAM))"
            adFormats:@[@(AdFormatBanner)]
            configurationClosure:^UIViewController * _Nonnull{
                return [[HTMLAdViewController alloc] init];
            }
        ],
        
        [
            [TestCase alloc]
            initWithTitle:@"Instream Video (Prebid + GIMA)"
            adFormats:@[@(AdFormatInstreamVideo)]
            configurationClosure:^UIViewController * _Nonnull{
                return [InstreamVideoIMAViewController new];
            }
        ],
    ];
}

@end
