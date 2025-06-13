//
//  TestCasesListViewController.m
//  TradecoreDemoObjectiveC
//
//  Created by Olena Stepaniuk on 15.05.2025.
//

#import "TestCasesListViewController.h"

NSString * const cellID = @"TestCaseCell";

@interface TestCasesListViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *adFormatPicker;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) AdFormat currentAdFormat;
@property (nonatomic) NSString *filterText;
@property (nonatomic) NSArray<TestCase *> *displayedCases;

@end

@implementation TestCasesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    self.displayedCases = TestCasesManager.allCases;
    
    [self setupPickers];
}

- (void)filterTestCases {
    self.displayedCases = [[NSMutableArray alloc] init];
    
    self.displayedCases = [TestCasesManager.allCases filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TestCase * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return self.filterText.length == 0 || [evaluatedObject.title rangeOfString:self.filterText options:NSCaseInsensitiveSearch].length > 0;
    }]];
    
    self.displayedCases = [self.displayedCases filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TestCase * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return self.currentAdFormat == AdFormatAll ? true : [evaluatedObject.adFormats containsObject:@(self.currentAdFormat)];
    }]];
    
    [self.tableView reloadData];
}

- (void)setupPickers {
    UIAction * allAdFormatsAction = [UIAction actionWithTitle:@"All" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        self.currentAdFormat = AdFormatAll;
        [self filterTestCases];
    }];
    
    NSMutableArray<UIAction *> * adFormatsActions = [[NSMutableArray alloc] initWithObjects:allAdFormatsAction, nil];
    
    for (int i = 0; i < AdFormatAll; ++i) {
        [adFormatsActions addObject:[UIAction actionWithTitle:[AdFormatDescriptor getDescriptionForAdFormat:(AdFormat)i] image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            self.currentAdFormat = (AdFormat)i;
            [self filterTestCases];
        }]];
    }
    
    self.adFormatPicker.showsMenuAsPrimaryAction = YES;
    self.adFormatPicker.changesSelectionAsPrimaryAction = YES;
    
    adFormatsActions.firstObject.state = UIMenuElementStateOn;
    
    UIMenu *adFormatMenu = [UIMenu menuWithChildren:adFormatsActions];
    self.adFormatPicker.menu = adFormatMenu;
    
    self.currentAdFormat = AdFormatAll;
    [self filterTestCases];
}

// MARK: - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.displayedCases.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    UIListContentConfiguration *configuration = cell.defaultContentConfiguration;
    configuration.text = self.displayedCases[indexPath.row].title;
    cell.contentConfiguration = configuration;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TestCase * testCase = self.displayedCases[indexPath.row];
    
    UIViewController * viewController = testCase.configurationClosure();
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.title = testCase.title;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

// MARK: - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.filterText = searchBar.text ? : @"";
    [self filterTestCases];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.filterText = searchBar.text ? : @"";
    [self filterTestCases];
    [searchBar endEditing:YES];
}

@end
