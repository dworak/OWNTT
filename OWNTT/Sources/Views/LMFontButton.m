//
//  LMFontButton.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 17/08/14.
//
//

#import "LMFontButton.h"

@interface LMFontButton (hidden)

- (NSString*)name;

@end


@implementation LMFontButton

- (void)awakeFromNib {
	self.titleLabel.font = [UIFont fontWithName:[self name] size:self.titleLabel.font.pointSize];
}


- (NSString*)name {
	assert(NO);
	return nil;
}

@end


@implementation DroidSansRegular

- (NSString*)name {
	return @"Droid Sans";
}

@end

