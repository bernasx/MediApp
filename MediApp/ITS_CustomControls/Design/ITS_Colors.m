//
//  ITS_Colors.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 05/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_Colors.h"

@implementation ITS_Colors

+ (UIColor *)primaryColor {
    //Dark blue
    return [UIColor colorWithRed:54.0/255.0 green:85.0/255.0 blue:155.0/255.0 alpha:1];
}

+ (UIColor *)secondaryColor {
    //light blue
    return [UIColor colorWithRed:106.0/255.0 green:196.0/255 blue:229.0/255.0 alpha:1];
}

+ (UIColor *)smallButtonAndTitleColor {
    //dark gray
    return [UIColor colorWithRed:65.0/255.0 green:65.0/255.0 blue:65.0/255.0 alpha:1];
}

+ (UIColor *)smallTextColor {
    //light gray
    return [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1];
}



@end
