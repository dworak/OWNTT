//
//  LMTabBarViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import "LMTabBarViewController.h"
#import "LMWebViewController.h"

@interface LMTabBarViewController () <UITabBarControllerDelegate>

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
