//
//  ITS_LoginViewController.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 05/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITS_Colors.h"
#import "ITS_TextFieldComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface ITS_LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet ITS_TextFieldComponent *passwordView;
@property (weak, nonatomic) IBOutlet ITS_TextFieldComponent *emailView;
@end

NS_ASSUME_NONNULL_END
