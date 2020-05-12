//
//  ITS_AddTableViewCell.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 11/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITS_Enums.h"
#import "ITS_TextFieldComponent.h"
#import "ITS_TextFieldWithTableComponent.h"
#import "ITS_PickerViewComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface ITS_AddTableViewCell : UITableViewCell
- (void)setUpCellwithType:(TextFieldComponentType)textFieldComponentType andTitle:(NSString *)title andTextFieldType:(TextFieldType)textFieldType andSearchType:(SearchType)searchType andData:(NSArray*)dataArray andWidth:(CGFloat)width ;
@property (nonatomic) UIView* componentView;
@end

NS_ASSUME_NONNULL_END
