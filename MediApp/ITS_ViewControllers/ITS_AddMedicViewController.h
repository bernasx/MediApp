//
//  ITS_AddMedicViewController.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 07/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_ViewController.h"
#import "ITS_TextFieldComponent.h"
#import "ITS_Colors.h"
#import "ITS_AddMedicViewModel.h"
#import "ITS_TextFieldWithTableComponent.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_AddMedicViewController : ITS_ViewController
@property (weak, nonatomic) IBOutlet ITS_TextFieldComponent *firstNameComponentView;
@property (weak, nonatomic) IBOutlet ITS_TextFieldComponent *lastNameComponentView;
@property (weak, nonatomic) IBOutlet ITS_TextFieldComponent *ageComponentView;
@property (weak, nonatomic) IBOutlet ITS_TextFieldComponent *addressComponentView;
@property (weak, nonatomic) IBOutlet ITS_TextFieldComponent *postalCodeComponentView;
@property (weak, nonatomic) IBOutlet ITS_TextFieldComponent *naturalComponentView;
@property (weak, nonatomic) IBOutlet ITS_TextFieldComponent *nationalityComponentView;
@property (weak, nonatomic) IBOutlet ITS_TextFieldComponent *nifComponentView;
@property (weak, nonatomic) IBOutlet ITS_TextFieldComponent *ccNumberComponentView;
@property (weak, nonatomic) IBOutlet ITS_TextFieldWithTableComponent *specialtyComponentView;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *genderPickerView;
@property (weak, nonatomic) IBOutlet UILabel *personalDataSectionLabel;

@end

NS_ASSUME_NONNULL_END
