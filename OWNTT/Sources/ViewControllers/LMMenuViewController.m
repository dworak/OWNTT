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
#import "LMMenuNameView.h"

@interface LMMenuViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *shadowView;
@property (strong, nonatomic) NSMutableArray *userObjects;
@property (strong, nonatomic) NSManagedObjectContext *localContext;
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
    self.shadowView.image = [[UIImage imageNamed:@"top_shadow.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    LMMenuNameView *nameView = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@_iPhone", NSStringFromClass([LMMenuNameView class])] owner:self options:nil] objectAtIndex:0];
    [self.topView addSubview:nameView];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.parentViewController.navigationItem setBackBarButtonItem:backButtonItem];
    
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 88, 42)];
    titleImage.image = [UIImage imageNamed:@"tabbar_logo.png"];
    [self.parentViewController.navigationItem setTitleView:titleImage];
    
    [self.tableView registerNib:nil forCellReuseIdentifier:@"MenuCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor whiteColor];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.subMenuImage.backgroundColor = SUBMENU_BACKGROUND_COLOR;
    
    if(!IS_IPHONE_5)
    {
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 86)];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if  (!self.localContext)
    {
        self.localContext = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    }
    LMUser *user = [[LMUser fetchLMUsersInContext:self.localContext] objectAtIndex:0];
    if([self isKindOfClass:[LMReportMenuViewController class]])
    {
        self.userObjects = [NSMutableArray arrayWithArray:[LMUserReport fetchEntitiesOfClass:[LMUserReport class] inContext:self.localContext]];//[NSArray arrayWithArray:user.userReports.allObjects];
    }
    else
    {
        self.userObjects = [NSMutableArray arrayWithArray:user.userAlerts.allObjects];
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createDate" ascending:YES];
    self.userObjects = [NSMutableArray arrayWithArray:[self.userObjects sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]]];
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
    if(indexPath.row == self.userObjects.count-1)
    {
        ((LMMenuTableViewCell *)cell).separatorImage.hidden = YES;
    }
    else
    {
        ((LMMenuTableViewCell *)cell).separatorImage.hidden = NO;
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        LMReadOnlyUserObject *userObject = [self.userObjects objectAtIndex:indexPath.row];
        [self.localContext deleteObject:userObject];
        [LMUtils saveCoreDataContext:self.localContext];
        [self.userObjects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        NSLog(@"Unhandled editing style! %d", (int)editingStyle);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMReadOnlyUserObject *userObject = [self.userObjects objectAtIndex:indexPath.row];
    self.object = [LMData new];
    self.object.programIds = [NSArray arrayWithObject:((LMUserReport *)userObject).programId];
    if([userObject isKindOfClass:[LMUserReport class]])
    {
        self.object.reportId = ((LMUserReport *)userObject).reportObject.objectId;
    }
    [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_ModalWeb] sender:self];
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
