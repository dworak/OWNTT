//
//  COViewController.h
//  CrazyViewController
//
//  Created by Kaszuba Maciej on 10/03/14.
//  Copyright (c) 2014 Kaszuba Maciej. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LMViewControllerBaseDelegate <NSObject>
- (BOOL) scrollsToTopWithTextFieldOrigin;
- (BOOL) performScrollWithSpringAnimation;
- (CGFloat) marginBetweenCurrentTextFieldAndKeyboard;
- (CGFloat) initialSpringVelocity;
- (CGFloat) springWithDamping;
- (CGFloat) marginFromTopLayoutGuideIfscrollsToTopWithTextFieldOrigin;
@end

@interface LMViewControllerBase : UIViewController
// Add subview to content scroll view
- (void)addContentSubview:(UIView *)v;
- (void)setBouncesPropertyForRootView: (BOOL) bounces;
- (void)shakeAnimation:(NSArray*) views;
- (void)scrollToTopWithTextFieldOrigin: (NSDictionary*) userInfo;
- (void)returnToDefaultScrollContentSize:(BOOL)defaultContent withUserInfoDictionary:(NSDictionary*) userInfo;
@property (weak, nonatomic) UITextField *currentEditingTextField;
@property (strong, nonatomic, readonly) UIScrollView *contentScrollView;
@property (weak, nonatomic) id<LMViewControllerBaseDelegate> delegate;
@end
