//
//  LMSummaryBaseViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import "LMSummaryBaseViewController.h"
#import "LMDataPickerViewController.h"
#import <LM/LMViewControllerBase.h>

@interface LMSummaryBaseViewController ()

@end

@implementation LMSummaryBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.parentViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Firstly for purpouse of storing all of the fields we remove all of the items from view
    NSArray *subviews = self.view.subviews;
    
    for (UIView *v in subviews)
    {
        if ((v!=self.contentScrollView) && (![v conformsToProtocol:@protocol(UILayoutSupport)]))
        {
            if (v.tag!=BACKGROUND_IMAGE_VIEW_TAG && v.tag!=BACKGROUND_STATUS_BAR_TAG)
            {
                [v removeFromSuperview];
            }
        }
    }
    
    // Now  we add them directly to our scrolled one
    [subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        
        if((obj!=self.contentScrollView) && (![obj conformsToProtocol:@protocol(UILayoutSupport)]))
        {
            if (obj.tag!=BACKGROUND_IMAGE_VIEW_TAG && obj.tag!=BACKGROUND_STATUS_BAR_TAG)
            {
                [self addContentSubview:obj];
            }
        }
    }];

}

- (void)viewDidLayoutSubviews
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareChildForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneAction:(id)sender
{
    //SaveData
    if([self isValid])
    {
        [self saveObjectData];
        [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)saveObjectData
{
    
}

- (BOOL)isValid
{
    return NO;
}

- (void)pickerShow
{
    self.contentScrollView.contentSize = CGSizeMake(self.view.frame.size.width, [self.pickerViewController pickerHeight]);
}

- (void)pickerHide
{
    self.contentScrollView.contentSize = self.view.frame.size;
}

- (void)pickerWillShow
{
    
}

- (void)pickerWillHide
{
   
}

@end
