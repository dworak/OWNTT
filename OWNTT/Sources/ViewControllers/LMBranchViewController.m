//
//  LMBranchViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMBranchViewController.h"
#import "LMBranchTableViewCell.h"
#import "LMBranchAdvertiserViewController.h"
#import "LMBranchInstanceViewController.h"
#import "LMBranchProgramViewController.h"
#import "LMHeaderView.h"
#import "LMNavigationViewController.h"
#import "LMBranchReportViewController.h"
#import "LMBranchReportTableViewCell.h"
#import "LMReadOnlyObject.h"
#import "LMInstance.h"
#import "LMAdvertiser.h"
#import "LMProgram.h"
#import "LMReport.h"
#import "LMSiteAdvertiserWS.h"
#import "LMSiteWS.h"

@interface LMBranchViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *shadowView;
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
    
    self.shadowView.image = [[UIImage imageNamed:@"top_shadow.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_NORMAL,
                                            NSFontAttributeName: NAVIGATION_ITEM_FONT
                                             } forState:UIControlStateNormal];
    [backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_HIGHLIGHTEN,
                                             NSFontAttributeName: NAVIGATION_ITEM_FONT
                                             } forState:UIControlStateHighlighted];
    [self.parentViewController.navigationItem setBackBarButtonItem:backButtonItem];
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 88, 42)];
    titleImage.image = [UIImage imageNamed:@"tabbar_logo.png"];
    [self.parentViewController.navigationItem setTitleView:titleImage];
    
    if(!self.objectId)
    {
        self.objectId = [LMData new];
    }
    if(!self.objectId.instanceId)
    {
        self.objectId.instanceId = [LMUtils getCurrentInstance];
    }
    
    // Do any additional setup after loading the view.
    //check navigation controller type
    if([self.parentViewController.navigationController isKindOfClass:[LMNavigationViewController class]])
    {
        LMNavigationViewController *navController = (LMNavigationViewController *)self.parentViewController.navigationController;
        BOOL addHeader = NO;
        if(self.objectId && self.objectId.instanceId)
        {
            LMInstance *instance = [LMInstance fetchActiveEntityOfClass:[LMInstance class] withObjectID:self.objectId.instanceId inContext:self.managedObjectContext];
            if([self isKindOfClass:[LMBranchAdvertiserViewController class]] && instance.isReport8)
            {
                addHeader = YES;
            }
            else if([self isKindOfClass:[LMBranchProgramViewController class]] && instance.isReport1)
            {
                addHeader = YES;
            }
        }
        if(navController.controllerType.intValue == NavigationControllerType_Report && ![self isKindOfClass:[LMBranchReportViewController class]] && addHeader)
        {
            self.headerView = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@_iPhone", NSStringFromClass([LMHeaderView class])] owner:self options:nil] objectAtIndex:0];
            __weak LMBranchViewController *selfObject = self;
            [self.headerView setHeaderButtonTitle:[self headerbuttonTitle]];
            self.headerView.showReport = ^() {
                [selfObject getAllProgramIds];
                [selfObject.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_ModalWebPop] sender:selfObject];
            };
        }
    }
    
    //[self.tableView registerClass:[LMBranchTableViewCell class] forCellReuseIdentifier:@"BranchCell"];
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    [self getTableData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionNotificationChange) name:LM_CONNECTION_NOTIFICATION_CHANGE object:nil];
    [self.headerView setHeaderButtonTitle:[self headerbuttonTitle]];
    [self connectionNotificationChange];
    [self setLocalizationStrings];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (NSManagedObjectContext *)managedObjectContext
{
    if(!_managedObjectContext)
    {
        _managedObjectContext = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    }
    return _managedObjectContext;
}

- (void)prepareChildForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_ModalWebPop]])
    {
        if([segue.destinationViewController isKindOfClass:[TTHostViewController class]])
        {
            TTHostViewController *hostController = (TTHostViewController *)segue.destinationViewController;
            if([hostController.childViewController isKindOfClass:[LMWebViewController class]])
            {
                ((LMWebViewController *)hostController.childViewController).isPop = YES;
                if([self isKindOfClass:[LMBranchInstanceViewController class]])
                {
                    ((LMWebViewController *)hostController.childViewController).isInstance = YES;
                }
                else
                {
                    ((LMWebViewController *)hostController.childViewController).isInstance = NO;
                }
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

- (NSString *)cellIdentifier
{
    return @"BranchCell";
}

- (NSString *)headerbuttonTitle
{
    return LM_LOCALIZE(@"LMBranch_Report8");
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

- (UITableViewCell *)createNewCell
{
    UITableViewCell *cell = (LMBranchTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@_iPhone", NSStringFromClass([LMBranchTableViewCell class])] owner:self options:nil] objectAtIndex:0];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark -
#pragma mark Private methods
- (void)setLocalizationStrings
{
    
}

- (void)connectionNotificationChange
{
    [self getTableData];
}

- (void)getAllProgramIds
{
    
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier]];
    if(!cell) {
        cell = [self createNewCell];
    }
    LMReadOnlyObject *object = [self.tableData objectAtIndex:indexPath.row];
    if([cell isKindOfClass:[LMBranchReportTableViewCell class]])
    {
        ((LMBranchReportTableViewCell *)cell).cellButton.tag = indexPath.row;
        ((LMBranchReportTableViewCell *)cell).cellButton.titleLabel.font = DEFAULT_APP_FONT;
        [((LMBranchReportTableViewCell *)cell).cellButton setTitle:LM_LOCALIZE(object.name) forState:UIControlStateNormal];
        [((LMBranchReportTableViewCell *)cell).cellButton setTitle:LM_LOCALIZE(object.name)forState:UIControlStateHighlighted];
        [((LMBranchReportTableViewCell *)cell).cellButton setTitleColor:DEFAULT_APP_FONT_COLOR forState:UIControlStateHighlighted];
        [((LMBranchReportTableViewCell *)cell).cellButton setTitleColor:DEFAULT_APP_FONT_COLOR forState:UIControlStateNormal];
    }
    else
    {
        cell.textLabel.font = DEFAULT_APP_FONT;
        cell.textLabel.text = object.name;
        if(indexPath.row == self.tableData.count-1)
        {
            ((LMBranchTableViewCell *)cell).separatorImage.hidden = YES;
        }
        else
        {
            ((LMBranchTableViewCell *)cell).separatorImage.hidden = NO;
        }
    }
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
        id baseObject = [self.tableData objectAtIndex:indexPath.row];
        if([baseObject isKindOfClass:[LMReadOnlyObject class]])
        {
            LMReadOnlyObject *object = (LMReadOnlyObject *)baseObject;
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
                self.objectId.programIds = [NSArray arrayWithObject:object.objectId];
            }
            else if([object isKindOfClass:[LMReport class]])
            {
                self.objectId.reportId = object.objectId;
            }
        }
        else
        {
            if([baseObject isKindOfClass:[LMSiteWS class]])
            {
                self.objectId.siteId = ((LMSiteWS*)baseObject).objectId;
            }
            else if([baseObject isKindOfClass:[LMSiteAdvertiserWS class]])
            {
                self.objectId.siteAdvertiserId = ((LMSiteAdvertiserWS *)baseObject).objectId;
            }
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
        return 62;
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
