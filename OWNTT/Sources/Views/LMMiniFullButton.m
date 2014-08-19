//
//  LMMiniFullButton.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 19/08/14.
//
//

#import "LMMiniFullButton.h"

@implementation LMMiniFullButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (NSString *)imageName
{
    return @"_arrow_mini";
}

- (NSString *)backgroundImageName
{
    return @"button_pink_mini.png";
}

- (void)setupButton
{
    [super setupButton];
    [self.titleLabel setFont:UI_MINI_FULL_BUTTON_FONT];
    self.layer.cornerRadius = UI_MINI_FULL_BUTTON_CORNER_RADIOUS;
}

@end
