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

@interface LMSummaryBaseViewController : LMViewControllerBase <TTChildViewControllerProtocol>
@property (strong, nonatomic) LMDataPickerViewController *pickerViewController;
@property (strong, nonatomic) LMDatePickerViewController *datePickerController;
@property (unsafe_unretained, nonatomic) BOOL pickerViewShow;

@property (weak, nonatomic) IBOutlet UIImageView *subMenuImage;
@property (weak, nonatomic) IBOutlet UILabel *instanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *advertiserLabel;
@property (weak, nonatomic) IBOutlet UILabel *programLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) LMData *transactionData;

@property (strong, nonatomic) NSArray *pickerData;

- (void)saveObjectData;
- (BOOL)isValid;
@end
