//
//  LMAlertSummaryViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import "LMAlertSummaryViewController.h"
#import "LMButton.h"
#import "LMTextField.h"

@interface LMAlertSummaryViewController ()
@property (weak, nonatomic) IBOutlet LMTextField *alertNameTextField;
@property (weak, nonatomic) IBOutlet LMButton *dateFrom;
@property (weak, nonatomic) IBOutlet LMButton *dateTo;
@property (weak, nonatomic) IBOutlet LMButton *monitoringType;
@property (weak, nonatomic) IBOutlet LMButton *rateType;
@property (weak, nonatomic) IBOutlet LMButton *hourOfSend;
@property (weak, nonatomic) IBOutlet LMTextField *valueTextField;

@end

@implementation LMAlertSummaryViewController

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
