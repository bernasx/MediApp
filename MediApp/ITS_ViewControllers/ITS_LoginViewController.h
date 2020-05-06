//
//  ITS_LoginViewController.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 05/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITS_TextFieldComponent.h"
#import "ITS_ViewController.h"
#import <FirebaseAuth.h>
#import "ITS_LoginViewModel.h"
#import "ITS_ServiceErrorHandler.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_LoginViewController : ITS_ViewController
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet ITS_TextFieldComponent *passwordView;
@property (weak, nonatomic) IBOutlet ITS_TextFieldComponent *emailView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property ITS_LoginViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
