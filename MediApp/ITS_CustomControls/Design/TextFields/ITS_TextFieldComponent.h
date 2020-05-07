//
//  ITS_TextFieldComponent.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 05/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITS_Colors.h"
#import "ITS_Enums.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_TextFieldComponent : UIView <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;

- (void)initWithTitle:(NSString *)title andType:(TextFieldType)textfieldType andFrame:(CGRect)frame;
- (void)updateComponentType:(TextFieldType)textfieldType;
- (void)updateComponentStatus:(TextFieldStatus)textFieldStatus withWarningMessage:(NSString *) warningMessage;
- (bool)textfieldHasText;
- (NSInteger)textfieldSize;
- (NSString *)textfieldText;
@end

NS_ASSUME_NONNULL_END
