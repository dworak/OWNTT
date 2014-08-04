//
//  LMBranchInstanceViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMBranchInstanceViewController.h"
#import "LMInstance.h"

@interface LMBranchInstanceViewController ()
@end

@implementation LMBranchInstanceViewController

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
    self.parentViewController.title = @"Instancja";
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

- (NSString*)nextSegueKey
{
    return [LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushAdvertiserList];
}

#pragma mark -
#pragma mark === Private methods ===
- (void)getTableData
{
    self.tableData = [LMInstance fetchActiveEntityOfClass:[LMInstance class] inContext:self.managedObjectContext];
    [self.tableView reloadData];
}

@end
















