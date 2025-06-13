//
//  AdFormatDescriptor.h
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import <Foundation/Foundation.h>
#import "AdFormat.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdFormatDescriptor: NSObject

+ (NSString *)getDescriptionForAdFormat:(AdFormat)adFormat;

@end

NS_ASSUME_NONNULL_END
