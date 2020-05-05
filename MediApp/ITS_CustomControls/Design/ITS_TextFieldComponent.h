//
//  ITS_TextFieldComponent.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 05/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITS_Colors.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TextFieldType) {
    UITextFieldEmail,
    UITextFieldPassword,
    UITextFieldDate,
    UITextFieldTime,
    UITextFieldDefault
};

@interface ITS_TextFieldComponent : UIView
@property (strong, nonatomic) IBOutlet UIView *view;

- (void)initWithTitle:(NSString *)title andType:(TextFieldType)textfieldType;
- (void)initWithTitle:(NSString *)title andType:(TextFieldType)textfieldType andFrame:(CGRect)frame;
- (void)updateComponentType:(TextFieldType)textfieldType;
@end

NS_ASSUME_NONNULL_END
