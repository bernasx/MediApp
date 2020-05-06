//
//  ITS_Colors.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 05/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

/*
 Class for creating and managing the app's colors all in one place. 
 */

@interface ITS_Colors : NSObject
+ (UIColor *)primaryColor;
+ (UIColor *)secondaryColor;
+ (UIColor *)smallButtonAndTitleColor;
+ (UIColor *)smallTextColor;
+ (UIColor *)warningColor;
@end

NS_ASSUME_NONNULL_END
