//
//  ITS_Colors.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 05/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_Colors.h"

@implementation ITS_Colors

#pragma mark - Primary Colors
+ (UIColor *)primaryColor {
    //Dark blue
    return [UIColor colorWithRed:54.0/255.0 green:85.0/255.0 blue:155.0/255.0 alpha:1];
}

+ (UIColor *)secondaryColor {
    //light blue
    return [UIColor colorWithRed:106.0/255.0 green:196.0/255 blue:229.0/255.0 alpha:1];
}

#pragma mark - Button colors

+ (UIColor *)smallButtonAndTitleColor {
    //dark gray
    return [UIColor colorWithRed:65.0/255.0 green:65.0/255.0 blue:65.0/255.0 alpha:1];
}

#pragma mark - Text Colors

+ (UIColor *)smallTextColor {
    //light gray
    return [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1];
}

+ (UIColor *)warningColor {
    //red
    return [UIColor colorWithRed:255.0/255.0f green:126/255.0f blue:121/255.0f alpha:1.0];
}

#pragma mark - Cell Gradients

+ (CAGradientLayer *)mainMenuCellGradient {
    //colors are the same as above
    UIColor *colorOne = [self secondaryColor]; //light
    UIColor *colorTwo = [self primaryColor]; //dark
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor,colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    //make the gradient left to right
    headerLayer.startPoint = CGPointMake(1.1, 1.1);
    headerLayer.endPoint = CGPointMake(0.3, 0.3);
    return headerLayer;
}

+ (CAGradientLayer *)patientListCellGradient {
    //colors are the same as above
    UIColor *colorOne = [self secondaryColor]; //light
    UIColor *colorTwo = [self primaryColor]; //dark
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor,colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.3];
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    //make the gradient left to right
    headerLayer.startPoint = CGPointMake(0.0, 0.0);
    headerLayer.endPoint = CGPointMake(0.0, 1.0);
    return headerLayer;
}

@end
