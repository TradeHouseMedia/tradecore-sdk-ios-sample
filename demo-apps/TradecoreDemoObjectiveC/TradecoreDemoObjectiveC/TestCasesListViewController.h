//
//  TestCasesListViewController.h
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import <UIKit/UIKit.h>

#import "AdFormat.h"
#import "AdFormatDescriptor.h"
#import "TestCase.h"
#import "TestCasesManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestCasesListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@end

NS_ASSUME_NONNULL_END
