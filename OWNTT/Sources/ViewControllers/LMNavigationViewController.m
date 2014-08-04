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

@interface LMNavigationViewController ()
@property (strong, nonatomic) NSNumber *currentObjectId;
@end

@implementation LMNavigationViewController

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
    
    //clear navigation bar
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = YES;
    
    //setup layout for controller type
    UIViewController *currentTopViewController;
    switch (self.controllerType.intValue)
    {
        case NavigationControllerType_Report:
        {
            self.currentObjectId = [LMUtils getCurrentInstance];
            NSManagedObjectContext *mOC = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
            NSArray *instances = [LMInstance fetchActiveEntityOfClass:[LMInstance class] inContext:mOC];
            if(self.currentObjectId || instances.count < 2)
            {
                currentTopViewController = [LMUtils currentStoryboardControllerForIdentifier:NSStringFromClass([LMBranchAdvertiserViewController class])];
                self.viewControllers = [NSArray arrayWithObject:currentTopViewController];
            }
            else
            {
                currentTopViewController = [LMUtils currentStoryboardControllerForIdentifier:NSStringFromClass([LMBranchInstanceViewController class])];
                self.viewControllers = [NSArray arrayWithObject:currentTopViewController];
            }
            break;
        }
        case NavigationControllerType_ReportTemplate:
        {
            self.viewControllers = [NSArray arrayWithObject:[LMUtils currentStoryboardControllerForIdentifier:NSStringFromClass([LMBranchAdvertiserViewController class])]];
            break;
        }
        case NavigationControllerType_Alert:
        {
            self.viewControllers = [NSArray arrayWithObject:[LMUtils currentStoryboardControllerForIdentifier:NSStringFromClass([LMBranchProgramViewController class])]];
            break;
        }
        default:
            break;
    }
    [self prepareBranchController:currentTopViewController];
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
