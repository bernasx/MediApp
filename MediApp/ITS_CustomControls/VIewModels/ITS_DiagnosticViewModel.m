//
//  ITS_DiagnosticViewModel.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 22/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_DiagnosticViewModel.h"
@interface ITS_DiagnosticViewModel()
@property (nonatomic) ITS_Repository *repository;
@property (nonatomic) NSMutableArray* dataArray; //contains all data for building components
@property (nonatomic) NSMutableArray* sectionArray; //contains all section titles
@end
@implementation ITS_DiagnosticViewModel
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

#pragma mark - build screen


- (void)buildScreen {
    id<DiagnosticViewModelDelegate> strongDelegate = self.delegate;
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
        
        if ([strongDelegate respondsToSelector:@selector(addViewModel:didFinishBuildingScreenArray:andSectionArray:)]) {
            [strongDelegate addViewModel:self didFinishBuildingScreenArray:self.dataArray andSectionArray:self.sectionArray];
        }
        
    } ];
    
    [self addComponentToArrayAtSection:2 withComponentTitle:@"Email" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:2 withComponentTitle:@"Telemóvel" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];

    [self addComponentToArrayAtSection:3 withComponentTitle:@"Anexos do paciente" withType:TextFieldComponentTypeAttachment andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:@[@"Documentos",@"Extras"] andFrame:CGRectMake(0, 0, 414, 200) withTextFieldWidth:nil];
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
        default:
            break;
    }
    [[self.dataArray objectAtIndex:section] addObject:componentView];
}
@end
