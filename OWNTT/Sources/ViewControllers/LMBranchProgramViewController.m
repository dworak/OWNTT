//
//  LMBranchProgramViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMBranchProgramViewController.h"
#import "LMNavigationViewController.h"
#import "LMInstance.h"
#import "LMReadOnlyObject.h"
#import "LMProgram.h"
#import "LMAdvertiser.h"

@interface LMBranchProgramViewController ()

@end

@implementation LMBranchProgramViewController

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
    [self.parentViewController.navigationItem setTitle:@"Program"];
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

- (void)getTableData
{
    LMInstance *instance = [LMInstance fetchActiveEntityOfClass:[LMInstance class] withObjectID:self.objectId.instanceId inContext:self.managedObjectContext];
    if(instance) {
        NSMutableArray *programsArray = [NSMutableArray new];
        for(LMAdvertiser *advertiser in instance.advertisers.allObjects)
        {
            [programsArray addObjectsFromArray:advertiser.programs.allObjects];
        }
        NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        self.tableData = [programsArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
        [self.tableView reloadData];
    }
}

- (NSString *)nextSegueKey
{
    if([self.parentViewController.navigationController isKindOfClass:[LMNavigationViewController class]])
    {
        LMNavigationViewController *navController = (LMNavigationViewController *)self.parentViewController.navigationController;
        if(navController.controllerType.intValue == NavigationControllerType_Alert)
        {
            return [LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushAlertSummary];
        }
        else
        {
            return [LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushReport];
        }
    }
    return nil;
}

@end
