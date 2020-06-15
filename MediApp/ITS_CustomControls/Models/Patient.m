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
        self.previousDiseasesArray = [[NSMutableArray alloc] init];
        self.familyDiseasesArray = [[NSMutableArray alloc] init];
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

//Returns an array that will be used to fill in the EDIT screen
- (NSMutableArray *)arrayWithFullData {
    NSMutableArray* buildingArray = [[NSMutableArray alloc] init];
    [buildingArray addObject:self.firstNames];
    [buildingArray addObject:self.lastNames];
    [buildingArray addObject:[NSString stringWithFormat:@"%d",self.age]];
    [buildingArray addObject:self.gender];
    [buildingArray addObject:self.address];
    [buildingArray addObject:self.postalCode];
    [buildingArray addObject:self.natural];
    [buildingArray addObject:self.nationality];
    [buildingArray addObject:self.NIF];
    [buildingArray addObject:self.ccNumber];
    [buildingArray addObject:self.snsNumber];
    [buildingArray addObject:self.previousDiseasesArray];
    [buildingArray addObject:self.familyDiseasesArray];
    [buildingArray addObject:self.notesArray];
    [buildingArray addObject:self.diagnosticArray];
    [buildingArray addObject:self.email];
    [buildingArray addObject:self.phoneNumber];
    [buildingArray addObject:self.attachmentArray];
    
    return buildingArray;
}
@end
