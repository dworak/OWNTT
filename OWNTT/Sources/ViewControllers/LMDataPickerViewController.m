//
//  LMDataPickerViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import "LMDataPickerViewController.h"
#import "LMDataPickerView.h"

@interface LMDataPickerViewController ()
@property (strong, nonatomic) LMDataPickerView *pickerView;
@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) NSString *currentPickerValue;
@property (unsafe_unretained, nonatomic) int defaultRow;

@property (unsafe_unretained, nonatomic) BOOL pickerShow;
@end

@implementation LMDataPickerViewController

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

- (void)dealloc
{
    self.pickerView.pickerView.delegate = nil;
    self.pickerView.pickerView.dataSource = nil;
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

- (void)updateFrameForOrientation:(UIInterfaceOrientation)orintation
{
    CGRect pickerFrame = self.pickerView.frame;
    pickerFrame.origin.x = 0;
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

#pragma mark -
#pragma mark === Private methods ===
- (void)doneAction
{
    self.pickerViewDoneAction(self.currentPickerValue);
}

- (void)cancelAction
{
    self.pickerViewCancelAction();
}

#pragma mark -
#pragma mark === Public methods ===
- (void)selectPickerObject:(int)row
{
    self.defaultRow = row-1;
}

- (void)addPickerData:(NSArray *)pickerData
{
    self.isLocalizable = YES;
    self.pickerData = pickerData;
    [self.pickerView.pickerView reloadAllComponents];
}

- (void)showInView:(UIView *)view
{
    if(!self.pickerView)
    {
        self.pickerView = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@_iPhone", NSStringFromClass([LMDataPickerView class])] owner:self options:nil] objectAtIndex:0];
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
        pickerFrame.origin.x = 0;
        pickerFrame.origin.y = view.frame.size.height;
        self.pickerView.frame = pickerFrame;
        
        pickerFrame.origin.y = pickerFrame.origin.y - (pickerFrame.size.height);
        [UIView animateWithDuration:STANDARD_ANIMATION_DURATION animations:^{
            self.pickerView.frame = pickerFrame;
        } completion:^(BOOL finished) {
            if(self.defaultRow > -1)
            {
                [self.pickerView.pickerView selectRow:self.defaultRow inComponent:0 animated:YES];
                self.currentPickerValue = [self.pickerData objectAtIndex:self.defaultRow];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:PICKER_VIEW_SHOW_NOTIFICATION object:nil userInfo:nil];
        }];
    }
    else
    {
        if(self.defaultRow != -1)
        {
            [self.pickerView.pickerView selectRow:self.defaultRow inComponent:0 animated:YES];
            self.currentPickerValue = [self.pickerData objectAtIndex:self.defaultRow];
        }
        [self.pickerView.pickerView reloadAllComponents];
        [[NSNotificationCenter defaultCenter] postNotificationName:PICKER_VIEW_SHOW_NOTIFICATION object:nil userInfo:nil];
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
    pickerFrame.origin.x = 0;
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

#pragma mark -
#pragma mark === UIPickerView methods ===
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(self.isLocalizable)
    {
        return LM_LOCALIZE([self.pickerData objectAtIndex:row]);
    }
    else
    {
        return [self.pickerData objectAtIndex:row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	self.currentPickerValue = [self.pickerData objectAtIndex:row];
}

@end
