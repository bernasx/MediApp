//
//  ITS_SwitchComponent.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 20/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_SwitchComponent.h"
@interface ITS_SwitchComponent()
@property (nonatomic) BOOL switchIsOn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *componentSwitch;

@end
@implementation ITS_SwitchComponent
- (IBAction)onSwitch:(id)sender {
    self.switchIsOn = !self.switchIsOn;
}

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
- (void)initWithTitle:(NSString *)title andFrame:(CGRect)frame {
    self.frame = frame;
    self.view.frame = frame;
    [self.titleLabel setText:title];
    [self.titleLabel setTextColor:[ITS_Colors smallButtonAndTitleColor]];
    [self.componentSwitch setOnTintColor:[ITS_Colors primaryColor]];
}

- (id)getObjectData {
    return [NSNumber numberWithBool:self.switchIsOn];
}

- (CGFloat)getDefaultComponentHeight {
    return 60;
}
- (void)setSwitch:(NSNumber *)boolNumber {
   
}

- (void)setDefaultValueFromUser:(id)defaultValue {
    bool isOn = [defaultValue boolValue];
    [self.componentSwitch setOn:isOn];
}
@end
