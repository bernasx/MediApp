//
//  ITS_AddViewModel.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 11/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ITS_Repository.h"
#import "ITS_Enums.h"
#import "Specialty.h"
#import "Medic.h"
#import "Patient.h"
#import "ITS_BaseTextFieldComponent.h"
#import "ITS_TextFieldComponent.h"
#import "ITS_TextFieldWithTableComponent.h"
#import "ITS_PickerViewComponent.h"
#import "ITS_AttachmentComponent.h"
#import "ITS_ZipCodeComponent.h"
#import "ITS_SwitchComponent.h"
#import "ITS_DiagnosticComponent.h"
#import "ITS_TextViewComponent.h"
NS_ASSUME_NONNULL_BEGIN
@protocol AddViewModelDelegate;
@interface ITS_AddViewModel : NSObject
//static fetches
- (void)fetchSpecialties:(void (^)(NSArray * _Nullable))completion;
//build objects
- (void)buildObjectWithType:(MainMenuSelection)mainMenuSelection andWithArray:(NSArray *)buildingArray andSections:(NSArray *)sections andIsEditing:(bool)isEditing andOldObject:(id)oldObject completion:(void (^)(NSString * _Nullable))completion;
//build screens
- (void)buildScreen:(MainMenuSelection)addTypeSelection;
- (NSArray *)fillComponentsWithData:(NSMutableArray*)dataSourceArray andDataArray:(NSArray *)dataArray andSectionArray:(nonnull NSArray *)sectionArray;
@property (nonatomic, weak) id<AddViewModelDelegate> delegate;
@end

@protocol AddViewModelDelegate <NSObject>
- (void)addViewModel:(ITS_AddViewModel*)viewModel
             didFinishBuildingScreenArray:(NSArray *)dataArray andSectionArray:(NSArray*)sectionArray;
@end
NS_ASSUME_NONNULL_END
