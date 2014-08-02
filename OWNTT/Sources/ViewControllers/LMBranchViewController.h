//
//  LMBranchViewController.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMHostChildBaseViewController.h"

@interface LMBranchViewController : LMHostChildBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (void)hideBackButtonItem:(BOOL)hidden;
@end
