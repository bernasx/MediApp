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

#pragma mark - Static data calls
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

- (void)fetchDiseases:(void (^)(NSArray * _Nullable))completion {
    [self.repository fetchDiseases:^(NSArray * _Nullable arr) {
        NSMutableArray *diseasesArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in arr) {
            Disease *disease = [[Disease alloc] init];
            [disease initWithDict:dict];
            [diseasesArray addObject:disease];
        }
        completion(diseasesArray);
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
            [self buildForPatients]; 
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

- (void)buildForPatients {
    
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
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Código Postal" withType:TextFieldComponentTypeZip andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0,0,414,110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Naturalidade" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Nacionalidade" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"NIF" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Nº CC" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Nº de Utente" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self fetchDiseases:^(NSArray * _Nullable diseasesArray) {
        [self addComponentToArrayAtSection:1 withComponentTitle:@"Histórico de Doenças" withType:TextFieldComponentTypeTableView andTextFieldType:UITextFieldSearch andSearchType:SearchDisease andArray:diseasesArray andFrame:CGRectMake(0, 0, 414, 315) withTextFieldWidth:nil];
        
        [self addComponentToArrayAtSection:1 withComponentTitle:@"Histórico Familiar" withType:TextFieldComponentTypeTableView andTextFieldType:UITextFieldSearch andSearchType:SearchDisease andArray:diseasesArray andFrame:CGRectMake(0, 0, 414, 315) withTextFieldWidth:nil];
        
        [self addComponentToArrayAtSection:1 withComponentTitle:@"Notas" withType:TextFieldComponentTypeTextView andTextFieldType:UITextFieldSearch andSearchType:SearchDisease andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 350) withTextFieldWidth:nil];
        
        [self addComponentToArrayAtSection:1 withComponentTitle:@"Diagnóstico" withType:TextFieldComponentTypeDiagnostic andTextFieldType:UITextFieldSearch andSearchType:SearchDisease andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
        
        
        if ([strongDelegate respondsToSelector:@selector(addViewModel:didFinishBuildingScreenArray:andSectionArray:)]) {
            [strongDelegate addViewModel:self didFinishBuildingScreenArray:self.dataArray andSectionArray:self.sectionArray];
        }
        
    } ];
    
    [self addComponentToArrayAtSection:2 withComponentTitle:@"Email" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:2 withComponentTitle:@"Telemóvel" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];

    [self addComponentToArrayAtSection:3 withComponentTitle:@"Anexos do paciente" withType:TextFieldComponentTypeAttachment andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:@[@"Documentos",@"Extras"] andFrame:CGRectMake(0, 0, 414, 200) withTextFieldWidth:nil];
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
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Código Postal" withType:TextFieldComponentTypeZip andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0,0,414,110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Naturalidade" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Nacionalidade" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"NIF" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Nº CC" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self fetchSpecialties:^(NSArray * _Nullable specialtiesArray) {
        [self addComponentToArrayAtSection:1 withComponentTitle:@"Especialidade" withType:TextFieldComponentTypeTableView andTextFieldType:UITextFieldSearch andSearchType:SearchSpecialty andArray:specialtiesArray andFrame:CGRectMake(0, 0, 414, 315) withTextFieldWidth:nil];
        
        [self addComponentToArrayAtSection:1 withComponentTitle:@"Médico chefe:" withType:TextFieldComponentTypeSwitch andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 60) withTextFieldWidth:nil];
        
        if ([strongDelegate respondsToSelector:@selector(addViewModel:didFinishBuildingScreenArray:andSectionArray:)]) {
            [strongDelegate addViewModel:self didFinishBuildingScreenArray:self.dataArray andSectionArray:self.sectionArray];
        }
        
    } ];
    
    [self addComponentToArrayAtSection:2 withComponentTitle:@"Email" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:2 withComponentTitle:@"Telemóvel" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];

    [self addComponentToArrayAtSection:3 withComponentTitle:@"Anexos do médico" withType:TextFieldComponentTypeAttachment andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:@[@"Documentos",@"Extras"] andFrame:CGRectMake(0, 0, 414, 200) withTextFieldWidth:nil];
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
            [(ITS_AttachmentComponent*)componentView initWithTitle:title andFrame:frame andSectionArray:array];
            [(ITS_AttachmentComponent*)componentView setDelegate:(id)self.delegate];
            break;
        case TextFieldComponentTypeZip:
            componentView = [ITS_ZipCodeComponent new];
            [(ITS_ZipCodeComponent*)componentView initWithTitle:title andType:textFieldType andFrame:frame];
             break;
        case TextFieldComponentTypeSwitch:
            componentView = [ITS_SwitchComponent new];
            [(ITS_SwitchComponent *)componentView initWithTitle:title andFrame:frame];
            break;
        case TextFieldComponentTypeTextView:
            componentView = [ITS_TextViewComponent new];
            [(ITS_TextViewComponent*)componentView initWithTitle:title andFrame:frame];
            break;
        case TextFieldComponentTypeDiagnostic:
            componentView = [ITS_DiagnosticComponent new];
            [(ITS_DiagnosticComponent*)componentView initWithTitle:title andFrame:frame];
            [(ITS_DiagnosticComponent*)componentView setDelegate:(id)self.delegate];
            break;
        default:
            break;
    }
    [[self.dataArray objectAtIndex:section] addObject:componentView];
}

#pragma mark - Object Construction
//sections are the sections for attachments 
- (void)buildObjectWithType:(MainMenuSelection)mainMenuSelection andWithArray:(NSArray *)buildingArray andSections:(NSArray *)sections{
    switch (mainMenuSelection) {
        case MainMenuSelectionMedics:
            [self buildMedicObject:buildingArray withSections:(NSArray*)sections];
            break;
        case MainMenuSelectionPatients:
            [self buildPatientObject:buildingArray withSection:sections];
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

- (void)buildMedicObject:(NSArray *)buildingArray withSections:(NSArray*)sections {
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
    [medic setIsSuperior:[[buildingArray objectAtIndex:11] boolValue]];
    [medic setEmail:[buildingArray objectAtIndex:12]];
    [medic setPhoneNumber:[buildingArray objectAtIndex:13]];
    [medic setAttachmentArray:[buildingArray objectAtIndex:14]];
    NSString*currentUserUID = [FIRAuth auth].currentUser.uid;
    [medic setSuperior:currentUserUID];
    [self.repository registerSeparateUserWithEmail:medic.email completion:^(NSString * _Nonnull uid) {
        [self.repository writeNewMedic:medic withUID:uid andWithSections:(NSArray*)sections];
    }];
}

-(void)buildPatientObject:(NSArray *)buildingArray withSection:(NSArray *)sections {
    Patient *patient = [[Patient alloc] init];
    [patient setFirstNames:[buildingArray objectAtIndex:0]];
    [patient setLastNames:[buildingArray objectAtIndex:1]];
    [patient setAge:[[buildingArray objectAtIndex:2] intValue]];
    [patient setGender:[buildingArray objectAtIndex:3]];
    [patient setAddress:[buildingArray objectAtIndex:4]];
    [patient setPostalCode:[buildingArray objectAtIndex:5]];
    [patient setNatural:[buildingArray objectAtIndex:6]];
    [patient setNationality:[buildingArray objectAtIndex:7]];
    [patient setNIF:[buildingArray objectAtIndex:8]];
    [patient setCcNumber:[buildingArray objectAtIndex:9]];
    [patient setSnsNumber:[buildingArray objectAtIndex:10]];
    [patient setPreviousDiseasesArray:[buildingArray objectAtIndex:11]];
    [patient setFamilyDiseasesArray:[buildingArray objectAtIndex:12]];
    [patient setNotes:[buildingArray objectAtIndex:13]];
    [patient setEmail:[buildingArray objectAtIndex:14]];
    [patient setPhoneNumber:[buildingArray objectAtIndex:15]];
    [patient setAttachmentArray:[buildingArray objectAtIndex:16]];
    
    [self.repository registerSeparateUserWithEmail:patient.email completion:^(NSString * _Nonnull uid) {
        [self.repository writeNewPatient:patient withUID:uid andWithSections:(NSArray*)sections];
    }];
}
@end
