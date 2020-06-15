//
//  Person.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 12/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.attachmentArray = [[NSMutableArray alloc] init];
        self.attachmentURLArray = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
