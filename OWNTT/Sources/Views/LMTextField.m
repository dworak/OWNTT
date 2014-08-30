//
//  LMTextField.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMTextField.h"

@interface LMTextField ()
@property (unsafe_unretained, nonatomic) LMTextFieldValidaitonType validationType;
@end

@implementation LMTextField

- (void)awakeFromNib {
    [self setupTextField];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupTextField];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
#pragma mark === Private methods ===
- (void)setupTextField
{
    self.validationType = LMTextFieldValidaitonType_None;
    
    self.backgroundColor = UI_TEXTFIELD_BACKGROUND_COLOR;
    
    self.layer.borderWidth = UI_TEXTFIELD_BORDER_WIDTH;
    self.layer.borderColor = UI_TEXTFIELD_BORDER_COLOR;
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_TEXTFIELD_TEXT_PADDING, 0)];
    [self setLeftViewMode:UITextFieldViewModeAlways];
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_TEXTFIELD_TEXT_PADDING, 0)];
    [self setRightViewMode:UITextFieldViewModeAlways];
    self.font = UI_TEXTFIELD_FONT;
    self.textColor = UI_TEXTFIELD_TEXT_COLOR;
}

#pragma mark -
#pragma mark === Public methods ===
- (void)addValidation:(LMTextFieldValidaitonType)validationType
{
    self.validationType = validationType;
}

- (NSString *)validateField
{
    switch (self.validationType)
    {
        case LMTextFieldValidaitonType_Login:
            if([LMUtils validateEmail:self.text])
            {
                return nil;
            }
            else
            {
                return LM_LOCALIZE(@"LMTextField_Login");
            }
        case LMTextFieldValidaitonType_Password:
        {
            if(self.text.length > 60 || self.text.length < 1)
            {
                return LM_LOCALIZE(@"LMTextField_Password");
            }
            else
            {
                return nil;
            }
        }
        case LMTextFieldValidaitonType_Name:
        {
            if(self.text.length > 60 || self.text.length < 1)
            {
                return LM_LOCALIZE(@"LMTextField_Name");
            }
            else
            {
                return nil;
            }
        }
        case LMTextFieldValidaitonType_Value:
        {
            NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
            [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber *number = [numberFormatter numberFromString:self.text];
            if(!number || number.intValue < 0 || number.intValue > 999999999)
            {
                return LM_LOCALIZE(@"LMTextField_Value");
            }
            else
            {
                return nil;
            }
        }
        default:
            return NO;
    }
}

@end
