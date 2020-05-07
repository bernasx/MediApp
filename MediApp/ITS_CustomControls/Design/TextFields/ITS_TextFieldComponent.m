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
@property (nonatomic) TextFieldStatus textFieldStatus;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@end

@implementation ITS_TextFieldComponent


#pragma mark - Inits

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

//init the object with a type and find out how to set it up. Frame will set up the view properly to fit the one in Storyboard
- (void)initWithTitle:(NSString *)title andType:(TextFieldType)textfieldType andFrame:(CGRect)frame {
    self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self.titleLabel setText:title]; //all of them have a similar title
    [self.titleLabel setTextColor:[ITS_Colors smallButtonAndTitleColor]];
    [self.warningLabel setHidden:YES]; //all warning labels should be hidden by default
    [self.warningLabel setTextColor:[ITS_Colors warningColor]];
    [self.textfield setTintColor:[ITS_Colors smallTextColor]]; //makes all icons the same color
    [self changeTextViewDesignWithColor:[ITS_Colors smallTextColor]]; //setup the textfield with whatever color we wish
    self.textfield.delegate = self;
    [self updateComponentType:textfieldType];
}

#pragma mark - View Design

//updates the componentType to allow 
- (void)updateComponentType:(TextFieldType)textfieldType {
    self.textFieldType = textfieldType;
    [self.textfield setSecureTextEntry:NO]; //if we change the type of text field, make sure it doesn't stay as securetext
    //update view
    switch (textfieldType) {
        case UITextFieldDefault:
            break;
        case UITextFieldEmail:
            [self setupWithLeftView:[UIImage systemImageNamed:@"envelope"] andRightView:nil];
            break;
        case UITextFieldPassword:
            [self.textfield setSecureTextEntry:YES];
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

//updates the status. Status means the coloring of the border and the label display.
- (void)updateComponentStatus:(TextFieldStatus)textFieldStatus withWarningMessage:(NSString *) warningMessage {
    switch (textFieldStatus) {
        case UITextFieldStatusNormal:
            [self.warningLabel setText:@""];
            [self.warningLabel setHidden:YES];
            [self changeTextViewDesignWithColor:[ITS_Colors smallTextColor]];
            break;
        case UITextFieldStatusWarning:
            [self.warningLabel setText:warningMessage];
            [self.warningLabel setHidden:NO];
            [self changeTextViewDesignWithColor:[ITS_Colors warningColor]];
            break;
        default:
            break;
    }
    
}

//Sets the images for the left and right views of the textfield. Pass a nil value to not put anything.
//Left view is always an image, right view is always a button.
- (void)setupWithLeftView:(UIImage *)leftImage andRightView:(UIImage *) rightImage{
    if(leftImage) {
        self.textfield.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 22, 22)];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView setImage:leftImage];
        UIView *container = [[UIView alloc] initWithFrame:imageView.frame];
        [container addSubview:imageView];
        [self.textfield setLeftView:container];
    }
    if(rightImage) {
        self.textfield.rightViewMode = UITextFieldViewModeAlways;
        UIButton * rightViewButton = [[UIButton alloc] initWithFrame:CGRectMake(-5, 0, 32, 32)];
        [rightViewButton setImage:rightImage forState:UIControlStateNormal];
        UIView *container = [[UIView alloc] initWithFrame:rightViewButton.frame];
        [self setButtonFunctionality:rightViewButton];
        [container addSubview:rightViewButton];
        [self.textfield setRightView:container];
    }
}

//adds an action to the target button, depending on the type of textfieldtype currently selected
- (void)setButtonFunctionality:(UIButton *)button {
    switch (self.textFieldType) {
        case UITextFieldPassword:
            [button addTarget:self action:@selector(passwordDown:) forControlEvents: UIControlEventTouchDown];
            break;
        case UITextFieldDate:
            //code for handling a date button click
            break;
        case UITextFieldTime:
            //code for handling a time button click
            break;
        default:
            break;
    }
}

- (void)passwordDown:(UIButton *)sender {
    self.textfield.secureTextEntry = !self.textfield.secureTextEntry;
    if(self.textfield.secureTextEntry) {
        sender.tintColor = [ITS_Colors smallTextColor];
    } else {
        sender.tintColor = [ITS_Colors smallButtonAndTitleColor];
    }
}

- (void)changeTextViewDesignWithColor: (UIColor *) color{
    self.textfield.layer.masksToBounds=YES;
    self.textfield.layer.borderColor = [color CGColor];
    self.textfield.layer.borderWidth= 1.0f;
    self.textfield.layer.cornerRadius = 8;
}

#pragma mark - Public Functions

- (bool)textfieldHasText {
    return self.textfield.hasText;
}

- (NSInteger)textfieldSize {
    return self.textfield.text.length;
}

- (NSString *)textfieldText {
    return self.textfield.text;
}



#pragma mark - UITextfield Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self updateComponentStatus:UITextFieldStatusNormal withWarningMessage:@""];
}

@end
