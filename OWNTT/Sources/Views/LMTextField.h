//
//  LMTextField.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    LMTextFieldValidaitonType_None = 0,
    LMTextFieldValidaitonType_Login,
    LMTextFieldValidaitonType_Password,
} LMTextFieldValidaitonType;

@interface LMTextField : UITextField
- (void)addValidation:(LMTextFieldValidaitonType)validationType;
- (NSString *)validateField;
@end
