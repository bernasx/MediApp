//
//  ITS_TextViewComponent.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 22/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_BaseTextFieldComponent.h"
#import "ITS_Colors.h"
#import "ITS_Enums.h"
#import "ITS_SearchTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_TextViewComponent : ITS_BaseTextFieldComponent <UITableViewDelegate,UITableViewDataSource,SearchTableViewCellDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
- (void)initWithTitle:(NSString *)title andFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
