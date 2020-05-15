//
//  ITS_TextFieldWithTableComponent.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 07/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITS_Enums.h"
#import "ITS_Colors.h"
#import "Specialty.h"
#import "Disease.h"
#import "ITS_SearchTableViewCell.h"
#import "ITS_BaseTextFieldComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface ITS_TextFieldWithTableComponent : ITS_BaseTextFieldComponent <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,SearchTableViewCellDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
- (void)initWithTitle:(NSString *)title andType:(TextFieldType)textfieldType andSearchType:(SearchType)searchType andFrame:(CGRect)frame andArray:(NSArray *)array;
- (void)updateComponentType:(TextFieldType)textfieldType andSearchType:(SearchType)searchType;
- (void)updateComponentStatus:(TextFieldStatus)textFieldStatus withWarningMessage:(NSString *) warningMessage;
- (bool)textfieldHasText;
- (NSInteger)textfieldSize;
- (NSString *)textfieldText;
- (NSArray *)getObjectArray;
- (id)getObjectData;
@end

NS_ASSUME_NONNULL_END
