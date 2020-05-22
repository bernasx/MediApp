//
//  ITS_TextViewComponent.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 22/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_TextViewComponent.h"
@interface ITS_TextViewComponent()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *componentTextView;
@end
@implementation ITS_TextViewComponent

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

//init the object with a type and find out how to set it up. Frame will set up the view properly to fit the one in Storyboard
- (void)initWithTitle:(NSString *)title andFrame:(CGRect)frame {
    self.frame = frame;
    self.view.frame = frame;
    [self.titleLabel setText:title]; //all of them have a similar title
    [self.titleLabel setTextColor:[ITS_Colors smallButtonAndTitleColor]];
    [self.componentTextView.layer setBorderWidth:1];
    [self.componentTextView.layer setBorderColor:[[ITS_Colors smallTextColor]CGColor]];
    [self.componentTextView.layer setCornerRadius:10];
}

#pragma mark - Public Functions

- (id)getObjectData {
    return [self.componentTextView text];
}

- (CGFloat)getDefaultComponentHeight {
    return 350;
}

@end
