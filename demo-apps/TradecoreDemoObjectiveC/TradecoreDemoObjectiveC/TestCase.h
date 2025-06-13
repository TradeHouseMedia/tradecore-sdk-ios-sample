//
//  TestCase.h
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import <UIKit/UIKit.h>
#import "AdFormat.h"

NS_ASSUME_NONNULL_BEGIN

typedef UIViewController* _Nonnull (^ConfigurationClosure)(void);

@interface TestCase: NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSArray<NSNumber *> *adFormats;
@property (nonatomic) ConfigurationClosure configurationClosure;

-(id)initWithTitle:(NSString *)title adFormats:(NSArray<NSNumber *> *)adFormats configurationClosure:(ConfigurationClosure)configurationClosure;

@end

NS_ASSUME_NONNULL_END
