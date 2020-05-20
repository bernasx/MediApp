//
//  ITS_SwitchComponent.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 20/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITS_BaseTextFieldComponent.h"
#import "ITS_Colors.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_SwitchComponent : ITS_BaseTextFieldComponent
@property (strong, nonatomic) IBOutlet UIView *view;
- (void)initWithTitle:(NSString *)title andFrame:(CGRect)frame;
- (id)getObjectData;
@end

NS_ASSUME_NONNULL_END
