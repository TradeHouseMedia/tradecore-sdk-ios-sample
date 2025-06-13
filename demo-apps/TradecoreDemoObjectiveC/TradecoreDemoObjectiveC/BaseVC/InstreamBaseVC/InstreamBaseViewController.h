//
//  InstreamBaseViewController.h
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InstreamBaseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeight;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;

@property (nonatomic, assign, readwrite) CGSize adSize;

- (IBAction)onReloadTapped:(id)sender;
- (IBAction)onPlayTapped:(id)sender;

@end

NS_ASSUME_NONNULL_END
