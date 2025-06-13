//
//  TestCase.m
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import "TestCase.h"

@implementation TestCase

- (id)initWithTitle:(NSString *)title adFormats:(NSArray<NSNumber *> *)adFormats configurationClosure:(ConfigurationClosure)configurationClosure {
    self = [self init];
    self.title = title;
    self.adFormats = adFormats;
    self.configurationClosure = configurationClosure;
    return self;
}

@end
