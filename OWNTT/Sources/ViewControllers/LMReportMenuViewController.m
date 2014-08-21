//
//  LMReportMenuViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import "LMReportMenuViewController.h"
#import "LMMenuNameView.h"

@interface LMReportMenuViewController ()

@end

@implementation LMReportMenuViewController

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
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"raporty_png.png"] forState:UIControlStateNormal];
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"raporty_png.png"] forState:UIControlStateHighlighted];
    for(UIView *view in self.topView.subviews)
    {
        if([view isKindOfClass:[LMMenuNameView class]])
        {
            ((LMMenuNameView *)view).titleLabel.text = @"DODAJ RAPORT";
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

@end
