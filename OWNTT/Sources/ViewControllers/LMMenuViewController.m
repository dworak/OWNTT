//
//  LMMenuViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import "LMAppDelegate.h"
#import "LMMenuViewController.h"
#import "LMMenuTableViewCell.h"
#import "LMReport.h"
#import "LMUserAlert.h"
#import "LMUserReport.h"
#import "LMAlertMenuViewController.h"
#import "LMReportMenuViewController.h"
#import "LMReadOnlyUserObject.h"
#import "LMData.h"
#import "LMWebViewController.h"

@interface LMMenuViewController ()
@property (strong, nonatomic) NSArray *userObjects;
@end

@implementation LMMenuViewController

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
    // Do any additional setup after loading the view.
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.parentViewController.navigationItem setBackBarButtonItem:backButtonItem];
    
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 118, 36)];
    titleImage.image = [UIImage imageNamed:@"logo.png"];
    [self.parentViewController.navigationItem setTitleView:titleImage];
    
    [self.tableView registerNib:nil forCellReuseIdentifier:@"MenuCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.subMenuImage.backgroundColor = SUBMENU_BACKGROUND_COLOR;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSManagedObjectContext *managedObjectContext = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    LMUser *user = [[LMUser fetchLMUsersInContext:managedObjectContext] objectAtIndex:0];
    if([self isKindOfClass:[LMReportMenuViewController class]])
    {
        self.userObjects = [LMUserReport fetchEntitiesOfClass:[LMUserReport class] inContext:managedObjectContext];//[NSArray arrayWithArray:user.userReports.allObjects];
    }
    else
    {
        self.userObjects = [NSArray arrayWithArray:user.userAlerts.allObjects];
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createDate" ascending:YES];
    self.userObjects = [self.userObjects sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (void)prepareChildForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[TTHostViewController class]])
    {
        TTHostViewController *hostController = (TTHostViewController *)segue.destinationViewController;
        if([hostController.childViewController isKindOfClass:[LMWebViewController class]])
        {
            ((LMWebViewController *)hostController.childViewController).transactionData = self.object;
        }
    }
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

- (IBAction)addButtonTapped:(id)sender {
    [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushInstanceList] sender:self];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    LMReadOnlyUserObject *userObject = [self.userObjects objectAtIndex:indexPath.row];
    if(!cell)
    {
        cell = (LMMenuTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@_iPhone", NSStringFromClass([LMMenuTableViewCell class])] owner:self options:nil] objectAtIndex:0];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    cell.textLabel.font = DEFAULT_APP_FONT;
    cell.textLabel.text = userObject.name;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMReadOnlyUserObject *userObject = [self.userObjects objectAtIndex:indexPath.row];
    self.object = [LMData new];
    if([userObject isKindOfClass:[LMUserReport class]])
    {
        self.object.reportId = ((LMUserReport *)userObject).reportObject.objectId;
    }
    [self performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushWeb] sender:self];
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

@end
