//
//  ITS_ZipCodeComponent.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 19/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_ZipCodeComponent.h"
@interface ITS_ZipCodeComponent()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *leftTextField;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UITextField *rightTextField;
@end

@implementation ITS_ZipCodeComponent
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
- (void)initWithTitle:(NSString *)title andType:(TextFieldType)textfieldType andFrame:(CGRect)frame {
    self.frame = frame;
    self.view.frame = frame;
    [self.titleLabel setText:title]; //all of them have a similar title
    [self.titleLabel setTextColor:[ITS_Colors smallButtonAndTitleColor]];
    [self.warningLabel setHidden:YES]; //all warning labels should be hidden by default
    [self.warningLabel setTextColor:[ITS_Colors warningColor]];
    [self.rightTextField setTintColor:[ITS_Colors smallTextColor]]; //makes all icons the same color
    [self.leftTextField setTintColor:[ITS_Colors smallTextColor]];
    [self changeTextViewDesignWithColor:[ITS_Colors smallTextColor]]; //setup the textfield with whatever color we wish
    self.rightTextField.delegate = self;
    self.leftTextField.delegate = self;
    [self.leftTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.rightTextField setKeyboardType:UIKeyboardTypeNumberPad];
    //make the textfield editing change
    [self.leftTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.rightTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - view design

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

- (bool)textfieldHasText{
    return ([self.leftTextField hasText] && [self.rightTextField hasText]);
}

- (id)getObjectData {
    return [NSString stringWithFormat:@"%@-%@",[self.leftTextField text],[self.rightTextField text]];
}


- (void)changeTextViewDesignWithColor: (UIColor *) color{
    self.rightTextField.layer.masksToBounds=YES;
    self.rightTextField.layer.borderColor = [color CGColor];
    self.rightTextField.layer.borderWidth= 1.0f;
    self.rightTextField.layer.cornerRadius = 8;
    
    self.leftTextField.layer.masksToBounds=YES;
    self.leftTextField.layer.borderColor = [color CGColor];
    self.leftTextField.layer.borderWidth= 1.0f;
    self.leftTextField.layer.cornerRadius = 8;
}

#pragma mark - UITextfield Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self updateComponentStatus:UITextFieldStatusNormal withWarningMessage:@""];
}


//Called when textfield changes
- (void)textFieldDidChange {
    [self updateComponentStatus:UITextFieldStatusNormal withWarningMessage:@""];
    if ([[self.leftTextField text] length] > 4) {
        NSString* tempString = [self.leftTextField text];
        tempString = [tempString substringToIndex:[tempString length] - 1];
        [self.leftTextField setText:tempString];
    }
    
    if ([[self.rightTextField text] length] > 3) {
        NSString* tempString = [self.rightTextField text];
        tempString = [tempString substringToIndex:[tempString length] - 1];
        [self.rightTextField setText:tempString];
    }
}

- (void)setDefaultValueFromUser:(id)defaultValue {
    NSArray *strings = [defaultValue componentsSeparatedByString:@"-"];
    [self.leftTextField setText:[strings objectAtIndex:0]];
    [self.rightTextField setText:[strings objectAtIndex:1]];
}

@end
