//
//  ITS_DiagnosticViewModel.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 22/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ITS_Repository.h"
#import "ITS_Enums.h"
#import "ITS_Colors.h"
#import "ITS_BaseTextFieldComponent.h"
#import "ITS_TextFieldComponent.h"
#import "ITS_TextFieldWithTableComponent.h"
#import "ITS_PickerViewComponent.h"
#import "ITS_AttachmentComponent.h"
#import "ITS_ZipCodeComponent.h"
#import "ITS_SwitchComponent.h"
#import "ITS_TextViewComponent.h"
NS_ASSUME_NONNULL_BEGIN
@protocol DiagnosticViewModelDelegate;
@interface ITS_DiagnosticViewModel : NSObject
@property (nonatomic, weak) id<DiagnosticViewModelDelegate> delegate;
- (void)buildScreen;
@end

@protocol DiagnosticViewModelDelegate<NSObject>
- (void)addViewModel:(ITS_DiagnosticViewModel*)viewModel
             didFinishBuildingScreenArray:(NSArray *)dataArray andSectionArray:(NSArray*)sectionArray;
@end


NS_ASSUME_NONNULL_END
