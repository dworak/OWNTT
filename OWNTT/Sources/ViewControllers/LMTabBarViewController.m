//
//  LMTabBarViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import "LMTabBarViewController.h"
#import "LMWebViewController.h"
#import "LMNavigationViewController.h"
#import "LMSettingsViewController.h"

@interface LMTabBarViewController () <UITabBarControllerDelegate>
@property (strong, nonatomic) UIImageView *pointerView;
@end

@implementation LMTabBarViewController

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
    self.delegate = self;
    [[self tabBar] setSelectedImageTintColor:[UIColor colorWithRed:232./255. green:73./255. blue:149./255. alpha:1.0]];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:232./255. green:73./255. blue:149./255. alpha:1.0]];
    //[[UITabBar appearance] setBarTintColor:[UIColor yellowColor]];
    
    CGRect sepFrame = CGRectMake(0, 0, 320, 1);
    UIView *seperatorView = [[UIView alloc] initWithFrame:sepFrame];
    seperatorView.backgroundColor = [UIColor colorWithRed:232./255. green:73./255. blue:149./255. alpha:1.0];
    seperatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.tabBar addSubview:seperatorView];
    
    //[UITabBarItem.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor purpleColor] }     forState:UIControlStateSelected];
    
    for(UIViewController *controller in self.viewControllers)
    {
        if([controller isKindOfClass:[LMNavigationViewController class]])
        {
            LMNavigationViewController *naVController = (LMNavigationViewController *)controller;
            switch (naVController.controllerType.intValue) {
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
        else
        {
            self.tabBarItem.title = LM_LOCALIZE(@"LMTabBar_Settings");
        }
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

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return (![viewController isEqual:self.selectedViewController]);
}

- (NSUInteger)supportedInterfaceOrientations
{
    /*if([self.presentedViewController isKindOfClass:[TTHostViewController class]])
    {
        TTHostViewController *hostController = (TTHostViewController *)self.presentedViewController;
        if([hostController.childViewController isKindOfClass:[LMWebViewController class]])
        {
            return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
        }
    }*/
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    /*if([self.presentedViewController isKindOfClass:[TTHostViewController class]])
    {
        TTHostViewController *hostController = (TTHostViewController *)self.presentedViewController;
        if([hostController.childViewController isKindOfClass:[LMWebViewController class]])
        {
            return YES;
        }
    }*/
    return NO;
}

@end
