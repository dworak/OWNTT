//
//  LMAlertMenuViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import "LMAlertMenuViewController.h"
#import "LMAlertSummaryViewController.h"
#import "LMMenuNameView.h"
#import "LMReadOnlyUserObject.h"
#import "LMUserAlert.h"

@interface LMAlertMenuViewController ()
@property (unsafe_unretained, nonatomic) int selectedUserAlertIndex;
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

- (void)prepareChildForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[TTHostViewController class]])
    {
        TTHostViewController *hostVC = (TTHostViewController *)segue.destinationViewController;
        if([hostVC.childViewController isKindOfClass:[LMAlertSummaryViewController class]])
        {
            ((LMAlertSummaryViewController *)hostVC.childViewController).readOnly = YES;
            ((LMAlertSummaryViewController *)hostVC.childViewController).userAlert = [self.userObjects objectAtIndex:self.selectedUserAlertIndex];
        }
    }
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
            ((LMMenuNameView *)view).titleLabel.text = LM_LOCALIZE(@"LMMenu_AddAlert");
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
    self.selectedUserAlertIndex = indexPath.row;
    [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushAlertSummary] sender:self];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        LMReadOnlyUserObject *userObject = [self.userObjects objectAtIndex:indexPath.row];
        [[LMOWNTTHTTPClient sharedClient] POSTHTTPRequestOperationForServiceName:LMOWNTTHTTPClientServiceName_UnregisterAlertPush parameters:[LMOWNTTHTTPClient unregisterAlertPushParamsToken:OWNTT_APP_DELEGATE.appUtils.currentUser.httpToken localId:((LMUserAlert *)userObject).objectId] succedBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.localContext deleteObject:userObject];
            [LMUtils saveCoreDataContext:self.localContext];
            [self.userObjects removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            [LMAlertManager showErrorAlertWithOkWithText:LM_LOCALIZE(@"LMAlertManager_AlertSummaryDeleteError") delegate:nil];
        }];
    } else {
        NSLog(@"Unhandled editing style! %d", (int)editingStyle);
    }
}

@end
