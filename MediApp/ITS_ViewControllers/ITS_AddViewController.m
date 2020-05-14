//
//  ITS_AddViewController.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 11/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_AddViewController.h"

@interface ITS_AddViewController ()
@property (nonatomic) ITS_AddViewModel *viewModel;
@property (nonatomic) NSMutableArray* dataArray; //contains all data for building components
@property (nonatomic) NSMutableArray* sectionArray; //contains all section titles
@end

@implementation ITS_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[ITS_AddViewModel alloc] init];
    [self buildScreen];//build the screen with textfields that represent what type of screen we're in
    
    //confirm button
    UIImage *confirmButtonImage = [UIImage systemImageNamed:@"checkmark"];
    UIBarButtonItem *confirmButton = [[UIBarButtonItem alloc] initWithImage:confirmButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapConfirmButton)];
    [self.navigationItem setRightBarButtonItem:confirmButton];
}

- (void)didTapConfirmButton{
    bool creationIsValid = YES;
    NSMutableArray* buildingArray = [NSMutableArray new]; //array that will store all the info for an object
    
    for (NSArray* array in self.dataArray) {
        for (ITS_BaseTextFieldComponent* component in array) {
            if ([component isKindOfClass:[ITS_TextFieldComponent class]]) {
                if (![(ITS_TextFieldComponent*)component textfieldHasText]) {
                    [(ITS_TextFieldComponent*)component updateComponentStatus:UITextFieldStatusWarning withWarningMessage:@"Por favor preencha este campo!"];
                    creationIsValid = NO;
                }
            }
            if ([component isKindOfClass:[ITS_TextFieldWithTableComponent class]]) {
                if ([[(ITS_TextFieldWithTableComponent*)component getObjectArray] count] < 1) {
                     [(ITS_TextFieldWithTableComponent*)component updateComponentStatus:UITextFieldStatusWarning withWarningMessage:@"Por favor insira pelo menos 1 elemento."];
                    creationIsValid = NO;
                }
                NSLog(@"%@",[(ITS_TextFieldWithTableComponent*)component getObjectArray]);
            }
            if ([component isKindOfClass:[ITS_PickerViewComponent class]]) {
                NSLog(@"%@",[(ITS_PickerViewComponent*)component currentSelection]);
            }
        }
    }
    
    if (creationIsValid) {
        for (NSArray* array in self.dataArray) {
            for (ITS_BaseTextFieldComponent* component in array) {
                [buildingArray addObject:component];
            }
        }
    }
}

#pragma mark - Tableview Delegate/Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.sectionArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = [self.dataArray objectAtIndex:section];
    return [sectionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"addTableViewCell";
    ITS_AddTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    ITS_BaseTextFieldComponent *viewHelper =[[self.dataArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    viewHelper.frame = CGRectMake(viewHelper.frame.origin.x, viewHelper.frame.origin.y, self.fieldsTableView.frame.size.width, viewHelper.frame.size.height);
    
    [cell addSubview:viewHelper];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ITS_BaseTextFieldComponent *component = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];//get component to check what height to give the cell
    if ([component isKindOfClass:[ITS_TextFieldComponent class]]) {
        return 110;
    }
    if ([component isKindOfClass:[ITS_TextFieldWithTableComponent class]]) {
        return 315;
    }
    if ([component isKindOfClass:[ITS_PickerViewComponent class]]) {
        return 110;
    }
    
    return 110;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *nibID = @"ITS_HeaderViewTableViewCell";
    ITS_HeaderViewTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:nibID owner:self options:nil] firstObject];
    [cell setTitleForSection:[self.sectionArray objectAtIndex:section]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

#pragma mark - Build the screen

//calls a function for every type of screen that should be built
- (void)buildScreen {
    switch (self.addTypeSelection) {
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

- (void)buildForMedics {
    
    self.dataArray = [NSMutableArray new];
    self.sectionArray = [NSMutableArray new];
    
    [self addSectionToArrayWithName:@"Dados Pessoais"];
    [self addSectionToArrayWithName:@"Dados Médicos"];
    [self addSectionToArrayWithName:@"Contatos"];
    
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
    
    [self.viewModel fetchSpecialties:^(NSArray * _Nullable specialtiesArray) {
        [self addComponentToArrayAtSection:1 withComponentTitle:@"Especialidade" withType:TextFieldComponentTypeTableView andTextFieldType:UITextFieldSearch andSearchType:SearchSpecialty andArray:specialtiesArray andFrame:CGRectMake(0, 0, 414, 315) withTextFieldWidth:nil];
        [self.fieldsTableView reloadData];
    } ];
    
    [self addComponentToArrayAtSection:2 withComponentTitle:@"Email" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldDefault andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];
    
    [self addComponentToArrayAtSection:2 withComponentTitle:@"Telemóvel" withType:TextFieldComponentTypeNormal andTextFieldType:UITextFieldNumber andSearchType:SearchSpecialty andArray:[NSArray new] andFrame:CGRectMake(0, 0, 414, 110) withTextFieldWidth:nil];

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
            [componentView updateComponentViewFrame:frame];
            if (width) {
                 [(ITS_TextFieldComponent *)componentView updateTextFieldWidth:[width intValue]];
            }
            break;
       case TextFieldComponentTypeTableView:
            componentView = [ITS_TextFieldWithTableComponent new];
            [(ITS_TextFieldWithTableComponent*)componentView initWithTitle:title andType:textFieldType andSearchType:searchType andFrame:frame andArray:array];
            [componentView updateComponentViewFrame:frame];
            break;
       case TextFieldComponentTypePickerView:
            componentView = [ITS_PickerViewComponent new];
            [(ITS_PickerViewComponent*)componentView initWithTitle:title andFrame:frame  withDataArray:array];
            [componentView updateComponentViewFrame:frame];
            break;
        default:
            break;
    }
    [[self.dataArray objectAtIndex:section] addObject:componentView];
}

@end
