//
//  Person.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 12/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attachment.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic) NSString* firstNames;
@property (nonatomic) NSString* lastNames;
@property (nonatomic) int age;
@property (nonatomic) NSString* gender;
@property (nonatomic) NSString* address;
@property (nonatomic) NSString* postalCode;
@property (nonatomic) NSString* natural;
@property (nonatomic) NSString* nationality;
@property (nonatomic) NSString* NIF;
@property (nonatomic) NSString* ccNumber;
@property (nonatomic) NSString* email;
@property (nonatomic) NSString* phoneNumber;
@property (nonatomic) NSMutableArray* attachmentArray;
@property (nonatomic) NSArray* attachmentURLArray;
@property (nonatomic) NSString* uid;
@end

NS_ASSUME_NONNULL_END
