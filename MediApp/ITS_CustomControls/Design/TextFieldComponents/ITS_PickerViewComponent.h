//
//  ITS_PickerViewComponent.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 11/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITS_Colors.h"
#import "ITS_BaseTextFieldComponent.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_PickerViewComponent : ITS_BaseTextFieldComponent <UIPickerViewDelegate,UIPickerViewDataSource>
- (void)initWithTitle:(NSString *)title andFrame:(CGRect)frame withDataArray:(NSArray *)dataArray;
- (NSString *)currentSelection;
- (id)getObjectData;
@end

NS_ASSUME_NONNULL_END
