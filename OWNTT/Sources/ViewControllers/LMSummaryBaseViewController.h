//
//  LMSummaryBaseViewController.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import <UIKit/UIKit.h>
#import "LMData.h"

@class LMDataPickerViewController;
@class LMDatePickerViewController;
@class LMBranchNameView;

@interface LMSummaryBaseViewController : LMViewControllerBase <TTChildViewControllerProtocol>
@property (weak, nonatomic) IBOutlet UIView *topImage;
@property (strong, nonatomic) LMBranchNameView *nameView;
@property (strong, nonatomic) LMDataPickerViewController *pickerViewController;
@property (strong, nonatomic) LMDatePickerViewController *datePickerController;
@property (weak, nonatomic) IBOutlet UIImageView *shadowImage;
@property (unsafe_unretained, nonatomic) BOOL pickerViewShow;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) LMData *transactionData;

@property (strong, nonatomic) NSArray *pickerData;

- (void)saveObjectData;
- (BOOL)isValid;
@end
