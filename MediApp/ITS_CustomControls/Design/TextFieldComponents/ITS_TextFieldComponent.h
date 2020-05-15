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
#import "ITS_BaseTextFieldComponent.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_TextFieldComponent : ITS_BaseTextFieldComponent <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;

- (void)updateComponentType:(TextFieldType)textfieldType;
- (void)updateComponentStatus:(TextFieldStatus)textFieldStatus withWarningMessage:(NSString *) warningMessage;
- (bool)textfieldHasText;
- (NSInteger)textfieldSize;
- (NSString *)textfieldText;
- (void)initWithTitle:(NSString *)title andType:(TextFieldType)textfieldType andFrame:(CGRect)frame;
- (void)updateTextFieldWidth:(int)constant;
- (id)getObjectData;
@end

NS_ASSUME_NONNULL_END
