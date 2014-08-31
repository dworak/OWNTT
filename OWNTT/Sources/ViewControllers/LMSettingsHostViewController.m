//
//  LMSettingsHostViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 31/08/14.
//
//

#import "LMSettingsHostViewController.h"

@implementation LMSettingsHostViewController
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        self.tabBarItem.title = LM_LOCALIZE(@"LMTabBar_Settings");
    }
    return self;
}
@end
