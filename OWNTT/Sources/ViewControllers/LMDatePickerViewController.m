//
//  LMDatePickerViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import "LMDatePickerViewController.h"
#import "LMDatePickerView.h"

@interface LMDatePickerViewController ()
@property (strong, nonatomic) LMDatePickerView *pickerView;
@property (strong, nonatomic) NSDate *defaultDate;

@property (unsafe_unretained, nonatomic) BOOL pickerShow;
@end

@implementation LMDatePickerViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateFrameForOrientation:(UIInterfaceOrientation)orintation
{
    CGRect pickerFrame = self.pickerView.frame;
    if(UIInterfaceOrientationIsLandscape(orintation))
    {
        pickerFrame.size.width = self.pickerView.superview.frame.size.width;
    }
    else
    {
        pickerFrame.size.width = self.pickerView.superview.frame.size.width;
    }
    pickerFrame.origin.y = self.pickerView.superview.frame.size.height;
    if(self.pickerShow)
    {
        pickerFrame.origin.y -= pickerFrame.size.height;
    }
    self.pickerView.frame = pickerFrame;
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

#pragma mark -
#pragma mark === Private methods ===
- (void)doneAction
{
    self.pickerViewDoneAction(self.pickerView.datePicker.date);
}

- (void)cancelAction
{
    self.pickerViewCancelAction();
}

#pragma mark -
#pragma mark === Public methods ===
- (void)setPickerDate:(NSDate *)date
{
    self.defaultDate = date;
}

- (void)showInView:(UIView *)view
{
    if(!self.pickerView)
    {
        self.pickerView = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@_iPhone", NSStringFromClass([LMDatePickerView class])] owner:self options:nil] objectAtIndex:0];
        self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.pickerView.cancelItem setTarget:self];
        [self.pickerView.cancelItem setAction:@selector(cancelAction)];
        [self.pickerView.doneItem setTarget:self];
        [self.pickerView.doneItem setAction:@selector(doneAction)];
    }
    if(!self.pickerShow)
    {
        self.pickerShow = YES;
        [view addSubview:self.pickerView];
        CGRect pickerFrame = self.pickerView.frame;
        pickerFrame.origin.y = view.frame.size.height;
        self.pickerView.frame = pickerFrame;
        
        pickerFrame.origin.y = view.frame.size.height - (pickerFrame.size.height + 44);
        [UIView animateWithDuration:STANDARD_ANIMATION_DURATION animations:^{
            self.pickerView.frame = pickerFrame;
        } completion:^(BOOL finished) {
            if(self.defaultDate)
            {
                [self.pickerView.datePicker setDate:self.defaultDate];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:PICKER_VIEW_SHOW_NOTIFICATION object:nil userInfo:nil];
        }];
    }
    else
    {
        if(self.defaultDate)
        {
            [self.pickerView.datePicker setDate:self.defaultDate];
        }
    }
}

- (void)hide
{
    if(!self.pickerShow)
    {
        return;
    }
    self.pickerShow = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:PICKER_VIEW_WILL_HIDE_NOTIFICATION object:nil userInfo:nil];
    CGRect pickerFrame = self.pickerView.frame;
    pickerFrame.origin.y = self.pickerView.superview.frame.size.height;
    [UIView animateWithDuration:STANDARD_ANIMATION_DURATION animations:^{
        self.pickerView.frame = pickerFrame;
    } completion:^(BOOL finished) {
        [self.pickerView removeFromSuperview];
        [[NSNotificationCenter defaultCenter] postNotificationName:PICKER_VIEW_HIDE_NOTIFICATION object:nil userInfo:nil];
    }];
}

- (CGFloat)pickerHeight
{
    return self.pickerView.frame.size.height;
}


@end
