//
//  MLSplashViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMSplashViewController.h"
#define DOWNLOAD_JSON_FILE_NAME @"tree"

@interface LMSplashViewController ()
@property (weak, nonatomic) IBOutlet UILabel *indicatorTextLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (void)splashViewControllerDidFinish;
@end

@implementation LMSplashViewController

- (void)prepareChildForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
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

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //TODO: add tree download mechanism
    [self.activityIndicator startAnimating];
    [self downloadJsonData];
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
- (void)splashViewControllerDidFinish
{
    [self.activityIndicator stopAnimating];
    self.indicatorTextLabel.hidden = YES;
    if(![LMUtils userExist]) {
        [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushLogin] sender:self.parentViewController];
    } else {
        [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushTabBar] sender:self.parentViewController];
    }
}

- (void)downloadJsonData
{
    NSError *error;
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:DOWNLOAD_JSON_FILE_NAME ofType:@"json"] options:NSDataReadingMapped error:&error];
    if(error) {
        NSLog(@"error: can't load json file");
    }
    //NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        NSLog(@"error: can't parse json file");
    }
    
    //Store data to database
    if(jsonArray) {
        for (NSDictionary *dict in jsonArray) {
            
        }
    }
    
    [self performSelector:@selector(splashViewControllerDidFinish) withObject:nil afterDelay:3];
}

@end
