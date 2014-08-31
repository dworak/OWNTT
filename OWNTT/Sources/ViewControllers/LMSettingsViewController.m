//
//  LMSettingsViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 28/07/14.
//
//
#import "LMBranchInstanceViewController.h"
#import "LMNavigationViewController.h"
#import "LMLoginViewController.h"
#import "LMSettingsViewController.h"
#import "LMInstance.h"
#import "LMUser.h"

@interface LMSettingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *instanceButton;
@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (weak, nonatomic) IBOutlet UIImageView *shadowImage;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LMSettingsViewController

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
    self.shadowImage.image = [[UIImage imageNamed:@"top_shadow.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    self.toolbar.clipsToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshView
{
    NSManagedObjectContext *managedObjectContext = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    NSArray *instances = [LMInstance fetchActiveEntityOfClass:[LMInstance class] inContext:managedObjectContext];
    if(instances.count < 2)
    {
        self.instanceButton.hidden = YES;
    }
    [self.nameButton setTitle:[NSString stringWithFormat:@"%@ %@", OWNTT_APP_DELEGATE.appUtils.currentUser.name, OWNTT_APP_DELEGATE.appUtils.currentUser.surname] forState:UIControlStateNormal];
    [self.nameButton setTitle:[NSString stringWithFormat:@"%@ %@", OWNTT_APP_DELEGATE.appUtils.currentUser.name, OWNTT_APP_DELEGATE.appUtils.currentUser.surname] forState:UIControlStateHighlighted];
    self.titleLabel.text = LM_LOCALIZE(@"LMSettingsTitleLabel");
    [self.instanceButton setTitle:LM_LOCALIZE(@"LMSettingInstanceButton") forState:UIControlStateNormal];
    [self.instanceButton setTitle:LM_LOCALIZE(@"LMSettingInstanceButton") forState:UIControlStateHighlighted];
    
    [self.refreshButton setTitle:LM_LOCALIZE(@"LMSettingRefreshButton") forState:UIControlStateNormal];
    [self.refreshButton setTitle:LM_LOCALIZE(@"LMSettingRefreshButton") forState:UIControlStateHighlighted];
    
    self.parentViewController.tabBarItem.title = LM_LOCALIZE(@"LMTabBar_Settings");
}

- (void)prepareChildForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[TTHostViewController class]])
    {
        TTHostViewController *hostController = (TTHostViewController *)segue.destinationViewController;
        if([hostController.childViewController isKindOfClass:[LMLoginViewController class]])
        {
            LMLoginViewController *loginController = (LMLoginViewController *)hostController.childViewController;
            loginController.isPresentModal = YES;
            loginController.showToolbar = YES;
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
- (IBAction)deleteButtonTapped:(id)sender
{
    [self instanceButtonTapped:nil];
    [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushLogin] sender:self];
}

- (IBAction)instanceButtonTapped:(id)sender
{
    int index = 0;
    [LMUtils removeCurrentInstance];
    for(UIViewController *controller in self.tabBarController.viewControllers)
    {
        if([controller isKindOfClass:[LMNavigationViewController class]])
        {
            LMNavigationViewController *navController = (LMNavigationViewController *)controller;
            if(navController.controllerType.intValue == NavigationControllerType_Report)
            {
                [navController popToRootViewControllerAnimated:NO];
                self.tabBarController.selectedViewController = navController;
            }
        }
        index++;
    }
}

- (IBAction)refreshButtonTapped:(id)sender
{
    [LMUtils performSynchronization:NO];
    [self instanceButtonTapped:nil];
}

@end



































