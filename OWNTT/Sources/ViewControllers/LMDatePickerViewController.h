//
//  LMDatePickerViewController.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import <UIKit/UIKit.h>

typedef void (^DatePickerViewDoneAction)(NSDate *value);
typedef void (^DatePickerViewCancelAction)();

@interface LMDatePickerViewController : UIViewController
@property (copy, nonatomic) DatePickerViewDoneAction pickerViewDoneAction;
@property (copy, nonatomic) DatePickerViewCancelAction pickerViewCancelAction;

- (void)setPickerDate:(NSDate *)date;
- (void)showInView:(UIView *)view;
- (void)hide;
- (CGFloat)pickerHeight;
@end
