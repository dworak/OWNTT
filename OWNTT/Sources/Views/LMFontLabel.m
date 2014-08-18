//
//  LMFontLabel.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 17/08/14.
//
//

#import "LMFontLabel.h"

@implementation LMFontLabel

- (id)init
{
    self = [super init];
    if (self)
    {
        self.font = [UIFont fontWithName:[self name] size:self.font.pointSize];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame]))
    {
        self.font = [UIFont fontWithName:[self name] size:self.font.pointSize];
    }
	
    return self;
}


- (id)initWithCoder:(NSCoder*)aDecoder {
	if ((self = [super initWithCoder:aDecoder]))
    {
        self.font = [UIFont fontWithName:[self name] size:self.font.pointSize];
	}
	
	return self;
}

- (void)awakeFromNib
{
    self.font = [UIFont fontWithName:[self name] size:self.font.pointSize];
}

- (void)layoutSubviews
{
	self.font = [UIFont fontWithName:[self name] size:self.font.pointSize];
}


- (NSString*)name
{
	assert(NO);
	return nil;
}

@end


@implementation DroidSansRegularLabel

- (NSString *)name
{
    return @"Droid Sans";
}

@end
