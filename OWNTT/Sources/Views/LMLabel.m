//
//  LMLabel.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 07/08/14.
//
//

#import "LMLabel.h"

@implementation LMLabel

- (void)awakeFromNib
{
    [self setupLabel];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupLabel];
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

- (void)setupLabel
{
    self.backgroundColor = [UIColor clearColor];
    self.font = DEFAULT_APP_FONT;
}

@end
