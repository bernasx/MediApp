//
//  Diagnostic.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 25/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface Diagnostic : NSObject
@property (nonatomic) NSString* treatment;
@property (nonatomic) NSArray* currentDiseases;
@property (nonatomic) NSArray* notesArray;
@property (nonatomic) NSArray* attachmentArray;
@property (nonatomic) NSUUID* uid;
@property (nonatomic) NSDate* creationDate;
//sections for the attachment array
@property (nonatomic)NSArray* attachmentsSections;
@end

NS_ASSUME_NONNULL_END
