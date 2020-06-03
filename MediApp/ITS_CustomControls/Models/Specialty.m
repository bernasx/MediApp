//
//  Specialty.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 08/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "Specialty.h"

@implementation Specialty
- (void)initWithDict:(NSDictionary *)dict {
    [self setSpecialtyName:[dict objectForKey:@"name"]];
    [self setSpecialtyJob:[dict objectForKey:@"job"]];
    [self setSpecialtyId:[dict objectForKey:@"id"]];
}
@end
