//
//  AdFormatDescriptor.m
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import "AdFormatDescriptor.h"

@implementation AdFormatDescriptor

+ (NSString *)getDescriptionForAdFormat:(AdFormat)adFormat {
    switch(adFormat) {
        case AdFormatBanner:
            return @"Banner";
        case AdFormatVideo:
            return @"Video";
        case AdFormatInstreamVideo:
            return @"Instream Video";
        case AdFormatAll:
            return @"All";
    }
}

@end
