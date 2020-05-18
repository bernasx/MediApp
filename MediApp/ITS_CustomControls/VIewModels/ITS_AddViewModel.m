//
//  ITS_AddViewModel.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 11/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_AddViewModel.h"
@interface ITS_AddViewModel()
@property (nonatomic) ITS_Repository *repository;
@property (nonatomic) NSMutableArray* dataArray; //contains all data for building components
@property (nonatomic) NSMutableArray* sectionArray; //contains all section titles
@end;

@implementation ITS_AddViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.repository = [[ITS_Repository alloc] init];
    }
    return self;
}

#pragma mark - Repository Calls
- (void)fetchSpecialties:(void (^)(NSArray * _Nullable))completion {
    [self.repository fetchSpecialties:^(NSArray * _Nullable arr) {
        NSMutableArray *specialtiesArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in arr) {
            Specialty *specialty = [[Specialty alloc] init];
            [specialty initWithDict:dict];
            [specialtiesArray addObject:specialty];
        }
        completion(specialtiesArray);
    }];
}

#pragma mark - Screen Construction


//calls a function for every type of screen that should be built
- (void)buildScreen:(MainMenuSelection)addTypeSelection {
    
    switch (addTypeSelection) {
        case MainMenuSelectionMedics:
            [self buildForMedics];
            break;
        case MainMenuSelectionPatients:
            //code for adding patients
            break;
        case MainMenuSelectionAppointments:
            //code for adding appointments
            break;
        case MainMenuSelectionMedicalAppointment:
            //code for adding medicalappointments
            break;
        default:
            break;
    }
}

- (void)buildForMedics{
    
    id<AddViewModelDelegate> strongDelegate = self.delegate;
    self.dataArray = [NSMutableArray new];
    self.sectionArray = [NSMutableArray new];
    
    [self addSectionToArrayWithName:@"Dados Pessoais"];
    [self addSectionToArrayWithName:@"Dados Médicos"];
    [self addSectionToArrayWithName:@"Contatos"];
    [self addSectionToArrayWithName:@"Anexos"];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Primeiros Nomes" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Apelidos" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Idade" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:[NSNumber numberWithInt:50]];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Sexo" withType:TextFieldComponentTypePickerView andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:@[@"Feminino",@"Masculino"] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Morada" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Código Postal" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:[NSNumber numberWithInt:100]];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Naturalidade" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Nacionalidade" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"NIF" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Nº CC" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self fetchSpecialties:^(NSArray * _Nullable specialtiesArray) {
        [self addComponentToArrayAtSection:1 withComponentTitle:@"Especialidade" withType:TextFieldComponentTypeTableView andTextFieldType:UITextFieldSearch andSearchType:SearchSpecialty andArray:specialtiesArray andFrame:CGRectMake(0, 0, 414, 315) withTextFieldWidth:nil];
        
        if ([strongDelegate respondsToSelector:@selector(addViewModel:didFinishBuildingScreenArray:andSectionArray:)]) {
            [strongDelegate addViewModel:self didFinishBuildingScreenArray:self.dataArray andSectionArray:self.sectionArray];
        }
        
    } ];
    
    [self addComponentToArrayAtSection:2 withComponentTitle:@"Email" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:2 withComponentTitle:@"Telemóvel" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];

    [self addComponentToArrayAtSection:3 withComponentTitle:@"Anexos do médico" withType:TextFieldComponentTypeAttachment andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 200) withTextFieldWidth:nil];
}



#pragma mark - array management

- (void)addSectionToArrayWithName:(NSString *)sectionName {
    [self.sectionArray addObject:sectionName];
    [self.dataArray addObject:[NSMutableArray new]];
}

- (void)addComponentToArrayAtSection:(NSInteger)section withComponentTitle:(NSString *)title withType:(TextFieldComponentType)textFieldComponentType andTextFieldType:(TextFieldType)textFieldType andSearchType:(SearchType)searchType andArray:(NSArray *)array andFrame:(CGRect)frame withTextFieldWidth:(NSNumber*)width {
    ITS_BaseTextFieldComponent *componentView;
    switch (textFieldComponentType) {
        case TextFieldComponentTypeNormal:
            componentView = [ITS_TextFieldComponent new];
            [(ITS_TextFieldComponent*)componentView initWithTitle:title andType:textFieldType andFrame:frame];
            if (width) {
                 [(ITS_TextFieldComponent *)componentView updateTextFieldWidth:[width intValue]];
            }
            break;
       case TextFieldComponentTypeTableView:
            componentView = [ITS_TextFieldWithTableComponent new];
            [(ITS_TextFieldWithTableComponent*)componentView initWithTitle:title andType:textFieldType andSearchType:searchType andFrame:frame andArray:array];
            break;
       case TextFieldComponentTypePickerView:
            componentView = [ITS_PickerViewComponent new];
            [(ITS_PickerViewComponent*)componentView initWithTitle:title andFrame:frame  withDataArray:array];
            break;
        case TextFieldComponentTypeAttachment:
            componentView = [ITS_AttachmentComponent new];
            [(ITS_AttachmentComponent*)componentView initWithTitle:title andFrame:frame];
            [(ITS_AttachmentComponent*)componentView setDelegate:(id)self.delegate];
        default:
            break;
    }
    [[self.dataArray objectAtIndex:section] addObject:componentView];
}

#pragma mark - Object Construction

- (void)buildObjectWithType:(MainMenuSelection)mainMenuSelection andWithArray:(NSArray *)buildingArray {
    switch (mainMenuSelection) {
        case MainMenuSelectionMedics:
            [self buildMedicObject:buildingArray];
            break;
        case MainMenuSelectionPatients:
            //build patient
            break;
        case MainMenuSelectionAppointments:
            //build appointments
            break;
        case MainMenuSelectionMedicalAppointment:
            //build medical appointment
            break;
        default:
            break;
    }
}

- (void)buildMedicObject:(NSArray *)buildingArray {
    Medic* medic = [[Medic alloc] init];
    [medic setFirstNames:[buildingArray objectAtIndex:0]];
    [medic setLastNames:[buildingArray objectAtIndex:1]];
    [medic setAge:[[buildingArray objectAtIndex:2] intValue]];
    [medic setGender:[buildingArray objectAtIndex:3]];
    [medic setAddress:[buildingArray objectAtIndex:4]];
    [medic setPostalCode:[buildingArray objectAtIndex:5]];
    [medic setNatural:[buildingArray objectAtIndex:6]];
    [medic setNationality:[buildingArray objectAtIndex:7]];
    [medic setNIF:[buildingArray objectAtIndex:8]];
    [medic setCcNumber:[buildingArray objectAtIndex:9]];
    [medic setSpecialtiesArray:[buildingArray objectAtIndex:10]];
    [medic setEmail:[buildingArray objectAtIndex:11]];
    [medic setPhoneNumber:[buildingArray objectAtIndex:12]];
    [medic setAttachmentArray:[buildingArray objectAtIndex:13]];
    
    [self.repository registerSeparateUserWithEmail:medic.email completion:^(NSString * _Nonnull uid) {
        [self.repository writeNewMedic:medic withUID:uid];
    }];
}
@end
