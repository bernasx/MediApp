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

//Decides what textfieldcomponent the view must display
typedef NS_ENUM(NSUInteger, TextFieldComponentType) {
    TextFieldComponentTypeNormal,
    TextFieldComponentTypeTableView,
    TextFieldComponentTypePickerView,
    TextFieldComponentTypeAttachment
};

//tells the textfieldcomponent which type it is handling
typedef NS_ENUM(NSUInteger, SearchType) {
    SearchSpecialty,
    SearchDisease
};

//tells the textfieldcomponent the status of the component
typedef NS_ENUM(NSUInteger, TextFieldStatus) {
    UITextFieldStatusNormal,
    UITextFieldStatusWarning
};

//Enum for the currently selected main menu
typedef NS_ENUM(NSUInteger, MainMenuSelection) {
    MainMenuSelectionMedicalAppointment,
    MainMenuSelectionPatients,
    MainMenuSelectionAppointments,
    MainMenuSelectionMedics
};

@end

NS_ASSUME_NONNULL_END
