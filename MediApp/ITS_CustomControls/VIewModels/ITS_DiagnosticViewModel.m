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
    [self addSectionToArrayWithName:@"Anexos"];
    
    [self addComponentToArrayAtSection:0 withComponentTitle:@"Tratamento" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self fetchDiseases:^(NSArray * _Nullable diseasesArray) {
        [self addComponentToArrayAtSection:1 withComponentTitle:@"Doenças" withType:TextFieldComponentTypeTableView andTextFieldType:UITextFieldSearch andSearchType:SearchDisease andArray:diseasesArray andFrame:CGRectMake(0, 0, 414, 315) withTextFieldWidth:nil];
    
        [self addComponentToArrayAtSection:1 withComponentTitle:@"Notas" withType:TextFieldComponentTypeTextView andTextFieldType:UITextFieldSearch andSearchType:SearchDisease andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 400) withTextFieldWidth:nil];
        
        if ([strongDelegate respondsToSelector:@selector(diagnosticViewModel:didFinishBuildingScreenArray:andSectionArray:)]) {
            [strongDelegate diagnosticViewModel:self didFinishBuildingScreenArray:self.dataArray andSectionArray:self.sectionArray];
        }
        
    } ];

    [self addComponentToArrayAtSection:2 withComponentTitle:@"Anexos do diagnostico" withType:TextFieldComponentTypeAttachment andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:@[@"Documentos",@"Extras"] andFrame:CGRectMake(0, 0, 414, 200) withTextFieldWidth:nil];
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


#pragma mark - object building

- (void)buildDiagnosticObject:(NSArray *)buildingArray withSections:(NSArray*)sections {
  //diagnostic building
    Diagnostic *diagnostic = [Diagnostic new];
    NSUUID* uid = [NSUUID UUID];
    [diagnostic setUid:uid];
    [diagnostic setTreatment:[buildingArray objectAtIndex:0]];
    [diagnostic setCurrentDiseases:[buildingArray objectAtIndex:1]];
    [diagnostic setNotesArray:[buildingArray objectAtIndex:2]];
    [diagnostic setAttachmentArray:[buildingArray objectAtIndex:3]];
    [diagnostic setAttachmentsSections:sections];
    [diagnostic setCreationDate:NSDate.date];
    //call delegate
    id<DiagnosticViewModelDelegate> strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(diagnosticViewModel:didFinishBuildingDiagnostic:)]) {
        [strongDelegate diagnosticViewModel:self didFinishBuildingDiagnostic:diagnostic];
    }
    
    
}
@end
