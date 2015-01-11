//
//  LMBranchSiteViewController.m
//  OwnTT Mobile
//
//  Created by Maciej Kaszuba on 11/01/15.
//
//

#import "LMBranchSiteViewController.h"

@interface LMBranchSiteViewController ()

@end

@implementation LMBranchSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString*)nextSegueKey
{
    return [LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushSiteAdvertiserList];
}

#pragma mark -
#pragma mark === Private methods ===
- (void)getTableData
{
    /*self.tableData = [LMInstance fetchActiveEntityOfClass:[LMInstance class] inContext:self.managedObjectContext];
    [self.tableView reloadData];*/
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if(((LMNavigationViewController *)self.navigationController).controllerType.intValue == NavigationControllerType_Report)
    {
        LMReadOnlyObject *object = [self.tableData objectAtIndex:indexPath.row];
        [LMUtils storeCurrentInstance:object.objectId];
    }*/
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

@end
