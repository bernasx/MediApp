//
//  Patient.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 21/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "Patient.h"

@implementation Patient
- (instancetype)init
{
    self = [super init];
    if (self) {
         self.notesArray = [[NSMutableArray alloc] init];
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
    
    //patient specific
    [self setSnsNumber:dict[@"snsNumber"]];
    
    //NOTE - Previous diseases and family history are not set here to save API calls when possible
}
@end
