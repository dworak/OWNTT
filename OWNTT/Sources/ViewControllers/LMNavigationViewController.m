//
//  MLNavigationViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMNavigationViewController.h"
#import "LMLoginViewController.h"
#import "LMBranchViewController.h"
#import "LMBranchAdvertiserViewController.h"
#import "LMBranchInstanceViewController.h"
#import "LMBranchProgramViewController.h"
#import "LMHeaderView.h"
#import "LMInstance.h"
#import "LMData.h"

@interface LMNavigationViewController ()
@property (strong, nonatomic) LMData *currentObjectId;
@end

@implementation LMNavigationViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self setLocalizationStrings];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_NORMAL,
       NSFontAttributeName: NAVIGATION_ITEM_FONT
       } forState:UIControlStateNormal];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_HIGHLIGHTEN,
       NSFontAttributeName: NAVIGATION_ITEM_FONT
       } forState:UIControlStateHighlighted];
    self.navigationBar.tintColor = NAVIGATION_ITEM_TEXT_COLOR_NORMAL;
    
    //clear navigation bar
    //[self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //self.navigationBar.shadowImage = [UIImage new];
    //self.navigationBar.translucent = YES;
    
    //setup layout for controller type
    UIViewController *currentTopViewController;
    self.currentObjectId = [LMData new];
    switch (self.controllerType.intValue)
    {
        case NavigationControllerType_Report:
        {
            NSNumber *instanceId = [LMUtils getCurrentInstance];
            self.currentObjectId.instanceId = instanceId;
            NSManagedObjectContext *mOC = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
            NSArray *instances = [LMInstance fetchActiveEntityOfClass:[LMInstance class] inContext:mOC];
            if(self.currentObjectId.instanceId || instances.count < 2)
            {
                NSMutableArray *controllers = [NSMutableArray new];
                currentTopViewController = [LMUtils currentStoryboardControllerForIdentifier:NSStringFromClass([LMBranchInstanceViewController class])];
                [self prepareBranchController:currentTopViewController];
                [controllers addObject:currentTopViewController];
                currentTopViewController = [LMUtils currentStoryboardControllerForIdentifier:NSStringFromClass([LMBranchAdvertiserViewController class])];
                [controllers addObject:currentTopViewController];
                self.viewControllers = controllers;
            }
            else
            {
                currentTopViewController = [LMUtils currentStoryboardControllerForIdentifier:NSStringFromClass([LMBranchInstanceViewController class])];
                self.viewControllers = [NSArray arrayWithObject:currentTopViewController];
            }
            [self prepareBranchController:currentTopViewController];
            break;
        }
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLocalizationStrings];
}

- (void)setLocalizationStrings
{
    switch (self.controllerType.intValue) {
        case NavigationControllerType_Report:
            self.tabBarItem.title = LM_LOCALIZE(@"LMTabBar_Report");
            break;
        case NavigationControllerType_Alert:
            self.tabBarItem.title = LM_LOCALIZE(@"LMTabBar_Alert");
            break;
        case NavigationControllerType_ReportTemplate:
            self.tabBarItem.title = LM_LOCALIZE(@"LMTabBar_Template");
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark -
#pragma mark === Private methods ===
- (void)prepareBranchController:(UIViewController *)bController
{
    if([bController isKindOfClass:[TTHostViewController class]])
    {
        TTHostViewController *hostController = (TTHostViewController *)bController;
        if([hostController.childViewController isKindOfClass:[LMBranchViewController class]])
        {
            LMBranchViewController *branchController = ((LMBranchViewController *)hostController.childViewController);
            [branchController currentBranchObjectId:self.currentObjectId];
        }
        
    }
}

@end
