//
//  ITS_ZipCodeComponent.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 19/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_BaseTextFieldComponent.h"
#import "ITS_Colors.h"
#import "ITS_Enums.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_ZipCodeComponent : ITS_BaseTextFieldComponent <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
- (void)updateComponentStatus:(TextFieldStatus)textFieldStatus withWarningMessage:(NSString *) warningMessage;
- (void)initWithTitle:(NSString *)title andType:(TextFieldType)textfieldType andFrame:(CGRect)frame;
- (id)getObjectData;
- (bool)textfieldHasText;
@end

NS_ASSUME_NONNULL_END
