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
    LMUser *user = [[LMUser fetchLMUsersInContext:managedObjectContext] objectAtIndex:0];
    self.nameLabel.text = user.name;
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
    //TODO: add load tree
    [self instanceButtonTapped:nil];
}

@end



































