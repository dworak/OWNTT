//
//  LMCustomNavigationViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 09/08/14.
//
//

#import "LMCustomNavigationViewController.h"

@interface LMCustomNavigationViewController () <UINavigationControllerDelegate> {
    BOOL _comingBack;
}

@end

@implementation LMCustomNavigationViewController

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
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_NORMAL,
       NSFontAttributeName: NAVIGATION_ITEM_FONT
       } forState:UIControlStateNormal];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_HIGHLIGHTEN,
       NSFontAttributeName: NAVIGATION_ITEM_FONT
       } forState:UIControlStateHighlighted];
    self.navigationBar.tintColor = NAVIGATION_ITEM_TEXT_COLOR_NORMAL;
    self.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    UIViewController *vc;
    if (self.presentedViewController) vc = self.presentedViewController;
    else vc = [self topViewController];
    return [vc supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate {
    UIViewController *vc;
    if (self.presentedViewController) vc = self.presentedViewController;
    else vc = [self topViewController];
    return [vc shouldAutorotate];
}

/*-(void)navigationController:(UINavigationController *)nc willShowViewController:(UIViewController *)vc animated:(BOOL)anim {
    if (self == vc)
        [nc setNavigationBarHidden:YES animated:_comingBack];
    else
        [nc setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_comingBack) {
        [self performSegueWithIdentifier:@"pushme" sender:self];
        _comingBack = YES;
    }
    else
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}*/

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
