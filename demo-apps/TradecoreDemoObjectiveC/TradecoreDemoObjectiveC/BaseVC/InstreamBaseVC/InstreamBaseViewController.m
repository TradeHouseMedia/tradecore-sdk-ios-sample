//
//  InstreamBaseViewController.m
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import "InstreamBaseViewController.h"

@interface InstreamBaseViewController ()
@end

@implementation InstreamBaseViewController

- (NSString *)nibName {
    return @"InstreamBaseViewController";
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
    
    self.playButton.layer.zPosition = CGFLOAT_MAX;
    [self.reloadButton setEnabled:false];
}

- (IBAction)onReloadTapped:(id)sender {
    [self.reloadButton setEnabled:false];
}

- (IBAction)onPlayTapped:(id)sender {
    [self.playButton setHidden:true];
}

@end
