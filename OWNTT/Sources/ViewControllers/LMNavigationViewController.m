//
//  MLNavigationViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMNavigationViewController.h"
#import "LMLoginViewController.h"

@interface LMNavigationViewController ()

@end

@implementation LMNavigationViewController

- (void)awakeFromNib {
    if(![LMUtils userExist]) {
        self.viewControllers = [NSArray arrayWithObject:[self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LMLoginViewController class])]];
    } else {
        self.viewControllers = [NSArray arrayWithObject:[LMUtils checkAndSetControllersByTreeHierarchyForStoryboard:self.storyboard]];
    }
}

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
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = YES;
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
