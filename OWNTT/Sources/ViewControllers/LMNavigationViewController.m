//
//  MLNavigationViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMNavigationViewController.h"
#import "LMLoginViewController.h"
#import "LMBranchAdvertiserViewController.h"
#import "LMBranchInstanceViewController.h"
#import "LMBranchProgramViewController.h"

@interface LMNavigationViewController ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //clear navigation bar
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = YES;
    
    //setup layout for controller type
    switch (self.controllerType.intValue)
    {
        case NavigationControllerType_Report:
        {
            self.viewControllers = [NSArray arrayWithObject:[LMUtils currentStoryboardControllerForIdentifier:NSStringFromClass([LMBranchInstanceViewController class])]];
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

@end
