//
//  ITS_LoginViewController.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 05/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_LoginViewController.h"

@interface ITS_LoginViewController ()

@end

@implementation ITS_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self designViewElements];
}

//Designs the view's elements and components with the proper characteristics
- (void) designViewElements {
    [self.navigationItem setTitle:@"Login"];
    [self.welcomeLbl setText:@"Bem-vindo à MediApp"];
    [self.welcomeLbl setTextColor:[ITS_Colors secondaryColor]];

    //setup textfield components
    [self.emailView initWithTitle:@"Email" andType:UITextFieldEmail andFrame:self.emailView.frame];
    [self.passwordView initWithTitle:@"Password" andType:UITextFieldPassword andFrame:self.passwordView.frame];
}



@end
