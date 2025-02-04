//
//  ITS_LoginViewController.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 05/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_LoginViewController.h"

@interface ITS_LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *privacyPolicyButton;

@property (weak, nonatomic) IBOutlet UIButton *termsAndConditionsButton;

@end

@implementation ITS_LoginViewController

#pragma mark - IBActions
- (IBAction)onLoginButtonTapped:(id)sender {
    bool validLogin = YES;
    //check textfields for text
    if (![self.emailView textfieldHasText]) {
        [self.emailView updateComponentStatus:UITextFieldStatusWarning withWarningMessage:NSLocalizedString(@"warning_fill_in_field",@"")];
        validLogin = NO;
    }
    if (![self.passwordView textfieldHasText]) {
        [self.passwordView updateComponentStatus:UITextFieldStatusWarning withWarningMessage:NSLocalizedString(@"warning_fill_in_field",@"")];
        validLogin = NO;
    }
    //if textfields were ok
    if (validLogin) {
        [self login];
    }
}

#pragma mark - Login and Navigation Methods
- (void)login {
    [self.viewModel logInUserWithEmail:self.emailView.textfieldText andPassword:self.passwordView.textfieldText completion:^(ITS_ServiceErrorHandler * _Nonnull errorHandler) {
        //if there was an error
        if (errorHandler.errorString) {
            //go through the error handler array, see what indexes must send out a warning
            for (int i = 0; i < errorHandler.errorIndexes.count; i++) {
                int index = [[errorHandler.errorIndexes objectAtIndex:i] intValue];
                switch (index) {
                    case -1:
                        //should display an alert
                        NSLog(@"%@",errorHandler.currentError.localizedDescription);
                        break;
                    case UITextFieldEmail:
                        [self.emailView updateComponentStatus:UITextFieldStatusWarning withWarningMessage:errorHandler.errorString];
                        break;
                    case UITextFieldPassword:
                        [self.passwordView updateComponentStatus:UITextFieldStatusWarning withWarningMessage:errorHandler.errorString];
                        break;
                    default:
                        break;
                }
            }
        } else {
            //login was successful
            [self instantiateNewViewController:@"mainMenuViewController"];
        }
    }];
}
//Instantiates and pushes a new view controller based on the storyboard identifier
- (void)instantiateNewViewController:(NSString *)identifier{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:identifier]; //Casts the initiated vc to the class it should be in
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  Initial Setup
- (void)viewDidLoad {
    [super viewDidLoad];
    [self designViewElements];
    self.viewModel = [[ITS_LoginViewModel alloc] init];
    [self.termsAndConditionsButton setTitle:NSLocalizedString(@"login_terms_and_conditions", @"") forState:UIControlStateNormal];
    [self.privacyPolicyButton setTitle:NSLocalizedString(@"login_privacy_policy", @"") forState:UIControlStateNormal];
    
    //[self.viewModel logOut];
    //[self.viewModel registerUserWithEmail:@"bernas@gmail.com" andPassword:@"123123123"];
    
    //keyboard dismiss when tapped anywhere
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    //auto login
    if ([[FIRAuth auth] currentUser]) {
        [self instantiateNewViewController:@"mainMenuViewController"];
    }
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

//Designs the view's elements and components with the proper characteristics
- (void)designViewElements {
    [self.navigationItem setTitle:@"Login"];
    [self.welcomeLabel setText:NSLocalizedString(@"login_welcome_message", @"")];
    [self.welcomeLabel setTextColor:[ITS_Colors secondaryColor]];

    //setup textfield components
    [self.emailView initWithTitle:@"Email" andType:UITextFieldEmail andFrame:CGRectMake(0, 0, self.emailView.frame.size.width, self.emailView.frame.size.height)];
    [self.passwordView initWithTitle:NSLocalizedString(@"login_password", @"") andType:UITextFieldPassword andFrame:CGRectMake(0, 0, self.passwordView.frame.size.width, self.passwordView.frame.size.height)];

    //setup button
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginButton setBackgroundColor:[ITS_Colors primaryColor]];
    [self.loginButton.layer setCornerRadius:8];
    [self.loginButton setClipsToBounds:YES];
    //button shadow
    [self.loginButton.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [self.loginButton.layer setShadowOffset:CGSizeMake(0, 2)];
    [self.loginButton.layer setShadowRadius:4];
    [self.loginButton.layer setShadowOpacity:0.8];
    [self.loginButton.layer setMasksToBounds:NO];
}



@end
