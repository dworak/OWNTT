//
//  LMSummaryBaseViewController.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import <UIKit/UIKit.h>

@class LMDataPickerViewController;

@interface LMSummaryBaseViewController : LMViewControllerBase <TTChildViewControllerProtocol>
@property (strong, nonatomic) LMDataPickerViewController *pickerViewController;
@property (unsafe_unretained, nonatomic) BOOL pickerViewShow;

@property (strong, nonatomic) NSArray *pickerData;
- (void)pickerShow;
- (void)pickerHide;

- (void)pickerWillShow;
- (void)pickerWillHide;
@end
