//
//  LMFullButton.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 09/08/14.
//
//

#import "LMFullButton.h"

@implementation LMFullButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [self setupButton];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setupButton
{
    self.exclusiveTouch = YES;
    self.backgroundColor = UI_FULL_BUTTON_BACKGROUND_COLOR;
    [self setBackgroundImage:[UIImage imageNamed:[self backgroundImageName]] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:[self backgroundImageName]] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:[self backgroundImageName]] forState:UIControlStateDisabled];
    //[self setTintColor:[UIColor grayColor]];
    [[self titleLabel] setTextAlignment:NSTextAlignmentLeft];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"gray%@.png", [self imageName]]] forState:UIControlStateHighlighted];
    [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"white%@.png", [self imageName]]] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[self setTitleColor:[UIColor colorWithRed:191.0f/255.0f green:191.0f/255.0f blue:191.0f/255.0f alpha:0.2] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2] forState:UIControlStateDisabled];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    self.tintColor = [UIColor whiteColor];
    
    //self.layer.borderWidth = UI_FULL_BUTTON_BORDER_WIDTH;
    //self.layer.borderColor = UI_FULL_BUTTON_BORDER_COLOR;
    self.layer.cornerRadius = UI_FULL_BUTTON_CORNER_RADIOUS;
    [self setTitleColor:UI_FULL_BUTTON_NORMAL_TEXT_COLOR forState:UIControlStateNormal];
    [self setTitleColor:UI_FULL_BUTTON_SELECTED_TEXT_COLOR forState:UIControlStateSelected];
    [self.titleLabel setFont:UI_FULL_BUTTON_FONT];
}

- (NSString *)imageName
{
   return @"_arrow";
}

- (NSString *)backgroundImageName
{
    return @"button_pink.png";
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super imageRectForContentRect:contentRect];
    frame.origin.x = CGRectGetMaxX(contentRect) - CGRectGetWidth(frame) -  self.imageEdgeInsets.right + self.imageEdgeInsets.left;
    return frame;
}

@end
