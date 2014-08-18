//
//  LMBranchViewController.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMHostChildBaseViewController.h"
#import "LMWebViewController.h"
#import "LMData.h"

@class LMHeaderView;

typedef enum {
    LMBranchControllerType_Normal,
    LMBranchControllerType_WithButton
} LMBranchControllerType;

@interface LMBranchViewController : LMHostChildBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tableData;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (unsafe_unretained, nonatomic) LMBranchControllerType branchControllerType;
@property (strong, nonatomic) LMHeaderView *headerView;
@property (strong, nonatomic) LMData *objectId;

- (void)hideBackButtonItem:(BOOL)hidden;
- (void)currentBranchObjectId:(LMData *)objectId;
- (UITableViewCell *)createNewCell;
- (NSString *)nextSegueKey;
- (NSString *)cellIdentifier;
- (void)getTableData;;
@end
