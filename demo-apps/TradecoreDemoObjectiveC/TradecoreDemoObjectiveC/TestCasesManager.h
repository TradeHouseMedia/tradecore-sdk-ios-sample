//
//  TestCasesManager.h
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import <Foundation/Foundation.h>
#import "TestCase.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestCasesManager : NSObject

+ (NSArray<TestCase *> *)allCases;

@end

NS_ASSUME_NONNULL_END
