//
//  Medic.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 15/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "Medic.h"

@implementation Medic
- (instancetype)init {
    self = [super init];
    if (self) {
        self.specialtiesArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)initWithDict:(NSDictionary *)dict andUid:(NSString*)uid{
    [self setFirstNames:dict[@"firstName"]];
    [self setLastNames:dict[@"lastName"]];
    [self setAge:[dict[@"age"] intValue]];
    [self setPhoneNumber:dict[@"phoneNumber"]];
    [self setUid:uid];
    [self setGender:dict[@"gender"]];
    [self setAddress:dict[@"address"]];
    [self setPostalCode:dict[@"postalCode"]];
    [self setNatural:dict[@"natural"]];
    [self setNationality:dict[@"nationality"]];
    [self setNIF:dict[@"NIF"]];
    [self setCcNumber:dict[@"ccNumber"]];
    [self setEmail:dict[@"email"]];
    [self setSpecialtyIds:dict[@"specialties"]];

    
    //medic specific
    [self setSuperior:dict[@"superior"]];
    [self setIsSuperior:dict[@"isSuperior"]];
    
    //NOTE - specialties handled outside
}
@end
