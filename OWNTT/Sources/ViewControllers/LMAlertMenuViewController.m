//
//  LMAlertMenuViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import "LMAlertMenuViewController.h"
#import "LMMenuNameView.h"

@interface LMAlertMenuViewController ()

@end

@implementation LMAlertMenuViewController

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
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"alert_png.png"] forState:UIControlStateNormal];
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"alert_png.png"] forState:UIControlStateHighlighted];
    for(UIView *view in self.topView.subviews)
    {
        if([view isKindOfClass:[LMMenuNameView class]])
        {
            ((LMMenuNameView *)view).titleLabel.text = @"DODAJ ALERT";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
