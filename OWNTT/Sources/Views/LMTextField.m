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
                return @"Login musi być w formacie e-mail i zawierać od 1 do 255 znaków";
            }
        case LMTextFieldValidaitonType_Password:
        {
            if(self.text.length > 60 || self.text.length < 1)
            {
                return @"Hasło musi zawierać od 1 do 60 znaków";
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
