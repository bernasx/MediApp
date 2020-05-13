//
//  ITS_PickerViewComponent.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 11/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_PickerViewComponent.h"
@interface ITS_PickerViewComponent()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic) NSArray* selectionArray;
@property (nonatomic) NSString* currentSelection;
@end
@implementation ITS_PickerViewComponent

#pragma mark - Inits

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self buildFrame];
    }
    return self;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildFrame];
    }
    return self;
}
//adds the view to the superview with a clear background
- (void)buildFrame {
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.view];
    [self.view.superview setBackgroundColor:[UIColor clearColor]];
}

//init the object with a title and find out how to set it up. Frame will set up the view properly
- (void)initWithTitle:(NSString *)title andFrame:(CGRect)frame withDataArray:(NSArray *)dataArray {
    self.frame = frame;
    [self.titleLabel setText:title];
    [self.titleLabel setTextColor:[ITS_Colors smallButtonAndTitleColor]];
    self.selectionArray = dataArray;
    [self setCurrentSelection:[self.selectionArray objectAtIndex:0]];
}

- (void)setViewFrame {
    self.view.frame = self.frame;
}

#pragma mark - UIPickerView delegate/datasource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.currentSelection = [self.selectionArray objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.selectionArray count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;

    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];

        pickerLabel.font = [UIFont fontWithName:@"SF-Pro-Text-Semibold"size:16];

        pickerLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    [pickerLabel setText:[self.selectionArray objectAtIndex:row]];
    [pickerLabel setAdjustsFontSizeToFitWidth:YES];
    [pickerLabel setMinimumScaleFactor:0.5];
    return pickerLabel;
}

- (NSString *)currentSelection {
    return self.currentSelection;
}
@end
