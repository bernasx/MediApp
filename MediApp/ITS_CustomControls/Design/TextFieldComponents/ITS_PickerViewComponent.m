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
}

- (void)setViewFrame {
    self.view.frame = self.frame;
}

@end
