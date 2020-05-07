//
//  ITS_AddMedicViewController.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 07/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_AddMedicViewController.h"

@interface ITS_AddMedicViewController ()

@end

@implementation ITS_AddMedicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self designViewElements];
}

//Designs the view's elements and components with the proper characteristics
- (void)designViewElements {
    [self.navigationItem setTitle:@"Novo Médico"];
    [self.genderLabel setTextColor:[ITS_Colors smallButtonAndTitleColor]];
    [self.personalDataSectionLabel setTextColor:[ITS_Colors primaryColor]];
    
    //setup textfield components
    [self.firstNameComponentView initWithTitle:@"Primeiro Nome" andType:UITextFieldDefault andFrame:self.firstNameComponentView.frame];
    [self.lastNameComponentView initWithTitle:@"Apelido" andType:UITextFieldDefault andFrame:self.lastNameComponentView.frame];
    [self.ageComponentView initWithTitle:@"Idade" andType:UITextFieldDefault andFrame:self.ageComponentView.frame];
    [self.addressComponentView initWithTitle:@"Morada" andType:UITextFieldDefault andFrame:self.addressComponentView.frame];
    [self.postalCodeComponentView initWithTitle:@"Código Postal" andType:UITextFieldDefault andFrame:self.postalCodeComponentView.frame];
    [self.naturalComponentView initWithTitle:@"Naturalidade" andType:UITextFieldDefault andFrame:self.naturalComponentView.frame];
    [self.nationalityComponentView initWithTitle:@"Nacionalidade" andType:UITextFieldDefault andFrame:self.nationalityComponentView.frame];
    [self.nifComponentView initWithTitle:@"NIF" andType:UITextFieldNumber andFrame:self.nifComponentView.frame];
    [self.ccNumberComponentView initWithTitle:@"Nº CC" andType:UITextFieldNumber andFrame:self.ccNumberComponentView.frame];

}

@end
