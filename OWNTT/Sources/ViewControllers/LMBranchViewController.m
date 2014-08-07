//
//  LMBranchViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMBranchViewController.h"
#import "LMBranchTableViewCell.h"
#import "LMHeaderView.h"
#import "LMNavigationViewController.h"
#import "LMReadOnlyObject.h"
#import "LMInstance.h"
#import "LMAdvertiser.h"
#import "LMProgram.h"
#import "LMReport.h"

@interface LMBranchViewController ()
@end

@implementation LMBranchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_NORMAL,
                                            NSFontAttributeName: NAVIGATION_ITEM_FONT
                                             } forState:UIControlStateNormal];
    [backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_HIGHLIGHTEN,
                                             NSFontAttributeName: NAVIGATION_ITEM_FONT
                                             } forState:UIControlStateHighlighted];
    [self.parentViewController.navigationItem setBackBarButtonItem:backButtonItem];
    
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 118, 36)];
    titleImage.image = [UIImage imageNamed:@"logo.png"];
    [self.parentViewController.navigationItem setTitleView:titleImage];
    
    // Do any additional setup after loading the view.
    self.managedObjectContext = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    
    //check navigation controller type
    if([self.parentViewController.navigationController isKindOfClass:[LMNavigationViewController class]])
    {
        LMNavigationViewController *navController = (LMNavigationViewController *)self.parentViewController.navigationController;
        if(navController.controllerType.intValue == NavigationControllerType_Report)
        {
            self.headerView = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@_iPhone", NSStringFromClass([LMHeaderView class])] owner:self options:nil] objectAtIndex:0];
            __weak LMBranchViewController *selfObject = self;
            self.headerView.showReport = ^() {
                [selfObject.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushWebPop] sender:selfObject];
            };
        }
    }
    
    [self.tableView registerNib:nil forCellReuseIdentifier:@"BranchCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self getTableData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}

- (void)prepareChildForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"LMSegueKeyType_PushWebPop"])
    {
        if([segue.destinationViewController isKindOfClass:[TTHostViewController class]])
        {
            TTHostViewController *hostController = (TTHostViewController *)segue.destinationViewController;
            if([hostController.childViewController isKindOfClass:[LMWebViewController class]])
            {
                ((LMWebViewController *)hostController.childViewController).isPop = YES;
            }
        }
    }
    else if([segue.destinationViewController isKindOfClass:[TTHostViewController class]])
    {
        TTHostViewController *hostController = (TTHostViewController *)segue.destinationViewController;
        if([hostController.childViewController isKindOfClass:[LMBranchViewController class]])
        {
            [((LMBranchViewController *)hostController.childViewController) currentBranchObjectId:self.objectId];
        }
    }
}

- (void)getTableData
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark === Public methods ===
- (void)hideBackButtonItem:(BOOL)hidden
{
    [self.parentViewController.navigationItem setHidesBackButton:hidden animated:NO];
}

- (void)currentBranchObjectId:(LMData *)objectId
{
    self.objectId = objectId;
}

- (NSString *)nextSegueKey
{
    return nil;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BranchCell"];
    if(!cell) {
        cell = (LMBranchTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@_iPhone", NSStringFromClass([LMBranchTableViewCell class])] owner:self options:nil] objectAtIndex:0];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    LMReadOnlyObject *object = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.font = DEFAULT_APP_FONT;
    cell.textLabel.text = object.name;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if([view isKindOfClass:[UITableViewHeaderFooterView class]])
    {
        ((UITableViewHeaderFooterView *)view).contentView.backgroundColor = HEADER_VIEW_BACKGROUND_COLOR;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    NSString *nextSegue = [self nextSegueKey];
    if(nextSegue)
    {
        if(!self.objectId)
        {
            self.objectId = [LMData new];
        }
        LMReadOnlyObject *object = [self.tableData objectAtIndex:indexPath.row];
        if([object isKindOfClass:[LMInstance class]])
        {
            self.objectId.instanceId = object.objectId;
        }
        else if([object isKindOfClass:[LMAdvertiser class]])
        {
            self.objectId.advertiserId = object.objectId;
        }
        else if([object isKindOfClass:[LMProgram class]])
        {
            self.objectId.programId = object.objectId;
        }
        else if([object isKindOfClass:[LMReport class]])
        {
            self.objectId.reportId = object.objectId;
        }
        [self.parentViewController performSegueWithIdentifier:nextSegue sender:self];
    }
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.headerView)
    {
        return 44;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

@end
