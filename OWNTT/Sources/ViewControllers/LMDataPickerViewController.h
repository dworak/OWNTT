//
//  LMDataPickerViewController.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import <UIKit/UIKit.h>

typedef void (^PickerViewDoneAction)(NSString *value);
typedef void (^PickerViewCancelAction)();

@interface LMDataPickerViewController : UIViewController
@property (copy, nonatomic) PickerViewDoneAction pickerViewDoneAction;
@property (copy, nonatomic) PickerViewCancelAction pickerViewCancelAction;

- (void)selectPickerObject:(int)row;
- (void)addPickerData:(NSArray *)pickerData;
- (void)showInView:(UIView *)view;
- (void)hide;
- (CGFloat)pickerHeight;
@end
