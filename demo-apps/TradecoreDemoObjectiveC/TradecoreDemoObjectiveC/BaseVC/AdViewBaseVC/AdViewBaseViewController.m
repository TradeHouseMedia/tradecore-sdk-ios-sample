//
//  AdViewBaseViewController.m
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import "AdViewBaseViewController.h"

@interface AdViewBaseViewController ()
@end

@implementation AdViewBaseViewController

- (NSString *)nibName {
    return @"AdViewBaseViewController";
}

- (instancetype)initWithAdSize:(CGSize)adSize {
    self = [super initWithNibName:self.nibName bundle:nil];
    if (self) {
        _adSize = adSize;
    }
    return self;
}

- (instancetype)init {
    return [self initWithAdSize:CGSizeMake(300, 250)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.containerWidth.constant = self.adSize.width;
    self.containerHeight.constant = self.adSize.height;
}

- (void)onReloadTapped:(UIButton *)sender {
    [self.reloadButton setEnabled:false];
}

@end
