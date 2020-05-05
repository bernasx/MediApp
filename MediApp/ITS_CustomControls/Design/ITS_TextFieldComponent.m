//
//  ITS_TextFieldComponent.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 05/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_TextFieldComponent.h"

@interface ITS_TextFieldComponent()
@property (nonatomic) TextFieldType textFieldType;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@end

@implementation ITS_TextFieldComponent

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        [self addSubview:self.view];
        [self.view.superview setBackgroundColor:[UIColor clearColor]];
    }
    return self;
    
}

#pragma mark - Inits

//init the object with a type and find out how to set it up
- (void)initWithTitle:(NSString *)title andType:(TextFieldType)textfieldType {
    [self.titleLabel setText:title]; //all of them have a similar title
    [self.titleLabel setTextColor:[ITS_Colors smallButtonAndTitleColor]];
    [self.warningLabel setHidden:YES]; //all warning labels should be hidden by default
    [self.textfield setTintColor:[ITS_Colors smallTextColor]]; //makes all icons the same color
    [self updateComponentType:textfieldType];
}

- (void)initWithTitle:(NSString *)title andType:(TextFieldType)textfieldType andFrame:(CGRect)frame {
    self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self.titleLabel setText:title]; //all of them have a similar title
    [self.titleLabel setTextColor:[ITS_Colors smallButtonAndTitleColor]];
    [self.warningLabel setHidden:YES]; //all warning labels should be hidden by default
    [self.textfield setTintColor:[ITS_Colors smallTextColor]]; //makes all icons the same color
    [self updateComponentType:textfieldType];
}

#pragma mark - View Design

//updates the componentType to allow 
- (void)updateComponentType:(TextFieldType)textfieldType {
    self.textFieldType = textfieldType;
    //update view
    switch (textfieldType) {
        case UITextFieldDefault:
            break;
        case UITextFieldEmail:
            [self setupWithLeftView:[UIImage systemImageNamed:@"envelope"] andRightView:nil];
            break;
        case UITextFieldPassword:
            [self setupWithLeftView:[UIImage systemImageNamed:@"lock"] andRightView:[UIImage systemImageNamed:@"eye"]];
            break;
        case UITextFieldDate:
            [self setupWithLeftView:nil andRightView:[UIImage systemImageNamed:@"calendar"]];
            break;
        case UITextFieldTime:
            [self setupWithLeftView:nil andRightView:[UIImage systemImageNamed:@"clock"]];
            break;
        default:
            break;
    }
}

- (void)setupWithLeftView:(UIImage *) leftImage andRightView:(UIImage *) rightImage{
    if(leftImage) {
        self.textfield.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 22, 22)];
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        [imgView setImage:leftImage];
        UIView *container = [[UIView alloc] initWithFrame:imgView.frame];
        [container addSubview:imgView];
        [self.textfield setLeftView:container];
    }
    if(rightImage) {
        self.textfield.rightViewMode = UITextFieldViewModeAlways;
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(-5, 0, 32, 32)];
        [btn setImage:rightImage forState:UIControlStateNormal];
        UIView *container = [[UIView alloc] initWithFrame:btn.frame];
        [container addSubview:btn];
        [self.textfield setRightView:container];
    }
}


@end
