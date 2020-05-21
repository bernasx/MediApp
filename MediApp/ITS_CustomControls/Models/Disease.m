//
//  Disease.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 08/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "Disease.h"

@implementation Disease
- (void)initWithDict:(NSDictionary *)dict {
    
    [self setDiseaseName:[dict objectForKey:@"name"]];
    [self setDiseaseId:[dict objectForKey:@"id"]];
}
@end
