//
//  ITS_Enums.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ITS_Enums : NSObject

//Enum for the type of textfield to pick for the textfieldcomponent. 
typedef NS_ENUM(NSUInteger, TextFieldType) {
    UITextFieldEmail,
    UITextFieldPassword,
    UITextFieldDate,
    UITextFieldTime,
    UITextFieldNumber,
    UITextFieldSearch,
    UITextFieldDefault
};

typedef NS_ENUM(NSUInteger, SearchType) {
    SearchSpecialty,
    SearchDisease
};

typedef NS_ENUM(NSUInteger, TextFieldStatus) {
    UITextFieldStatusNormal,
    UITextFieldStatusWarning
};

typedef NS_ENUM(NSUInteger, MainMenuSelection) {
    MainMenuSelectionMedicalAppointment,
    MainMenuSelectionPatients,
    MainMenuSelectionAppointments,
    MainMenuSelectionMedics
};

@end

NS_ASSUME_NONNULL_END
