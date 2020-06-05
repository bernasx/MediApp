//
//  Diagnostic.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 25/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "Diagnostic.h"

@implementation Diagnostic

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentDiseases = [[NSMutableArray alloc] init];
        self.notesArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)initWithDict:(NSDictionary *)dict andUid:(NSString*)uid{
    
    NSUUID* uuid = [[NSUUID alloc] initWithUUIDString:uid];
    [self setUid:uuid];
    [self setTreatment:dict[@"treatment"]];
    [self setCurrentDiseasesIds:dict[@"currentDiseases"]];
    

    
    [self setCreationDate:[NSDate dateWithTimeIntervalSinceReferenceDate:[dict[@"creationDate"] doubleValue]]];
}

//Returns an array that will be used to fill in the EDIT screen
- (NSMutableArray *)arrayWithFullData {
    NSMutableArray* buildingArray = [[NSMutableArray alloc] init];
    [buildingArray addObject:self.treatment];
    [buildingArray addObject:self.currentDiseases];
    [buildingArray addObject:self.notesArray];
    [buildingArray addObject:self.attachmentArray];
    return buildingArray;
}
@end
