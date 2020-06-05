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
@property (nonatomic) NSArray* dataArray; //contains all data for building components
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *cancelEditButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic) NSArray* sectionArray; //contains all section titles
@end

@implementation ITS_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[ITS_AddViewModel alloc] init];
    self.viewModel.delegate = self; //delegate will ensure we get the data back 
    [self.viewModel buildScreen:self.addTypeSelection];//build the screen with textfields that represent what type of screen we're in
    [self.cancelEditButton setHidden:YES];
    if (self.isEditing) {   
        [self.cancelEditButton setHidden:NO];
    }
    
    //Setup for scrolling smoothly
    self.tableViewHeight.constant = 0;
    self.fieldsTableView.scrollEnabled = NO;
    self.scrollView.bounces = NO;
    self.fieldsTableView.bounces = YES;
    
    [self designBottomButton:self.addButton];
    [self designBottomButton:self.cancelEditButton];
    
}

- (void)designBottomButton:(UIButton *)button {
    //setup button
    [self setupButtonTitle:button];
    [button setBackgroundColor:[ITS_Colors primaryColor]];
    [button.layer setCornerRadius:8];
    [button setClipsToBounds:YES];
    //button shadow
    [button.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [button.layer setShadowOffset:CGSizeMake(0, 2)];
    [button.layer setShadowRadius:4];
    [button.layer setShadowOpacity:0.8];
    [button.layer setMasksToBounds:NO];
}

- (void)setupButtonTitle:(UIButton*)button {
    switch (self.addTypeSelection) {
        case MainMenuSelectionMedics:
            [button setTitle:NSLocalizedString(@"add_button_medic", @"") forState:UIControlStateNormal];
            break;
        case MainMenuSelectionPatients:
            [button setTitle:NSLocalizedString(@"add_button_patient", @"") forState:UIControlStateNormal];
             break;
        case MainMenuSelectionAppointments:
            [button setTitle:NSLocalizedString(@"add_button_appointment", @"") forState:UIControlStateNormal];
             break;
        case MainMenuSelectionMedicalAppointment:
            [button setTitle:NSLocalizedString(@"add_button_medical_appointment", @"") forState:UIControlStateNormal];
             break;
        default:
            break;
    }
    
    if ([button isEqual:self.cancelEditButton]) {
        [button setTitle:@"Cancelar" forState:UIControlStateNormal];
    }
}

- (IBAction)didTapConfirmButton:(id)sender {
    bool creationIsValid = YES;
    NSMutableArray* buildingArray = [NSMutableArray new]; //array that will store all the info for an object
    
    for (NSArray* array in self.dataArray) {
        //go through each component, check if they're valid fields
        for (ITS_BaseTextFieldComponent* component in array) {
            if ([component isKindOfClass:[ITS_TextFieldComponent class]]) {
                if (![(ITS_TextFieldComponent*)component textfieldHasText]) {
                    [component updateComponentStatus:UITextFieldStatusWarning withWarningMessage:@"Por favor preencha este campo!"];
                    creationIsValid = NO;
                }
            }
            
            if ([component isKindOfClass:[ITS_ZipCodeComponent class]]) {
                if (![(ITS_ZipCodeComponent*)component textfieldHasText]) {
                    [component updateComponentStatus:UITextFieldStatusWarning withWarningMessage:@"Por favor preencha este campo!"];
                    creationIsValid = NO;
                }
            }
            if ([component isKindOfClass:[ITS_TextFieldWithTableComponent class]]) {
                if ([[(ITS_TextFieldWithTableComponent*)component getObjectArray] count] < 1) {
                    [component updateComponentStatus:UITextFieldStatusWarning withWarningMessage:@"Por favor insira pelo menos 1 elemento."];
                    creationIsValid = NO;
                }
                NSLog(@"%@",[(ITS_TextFieldWithTableComponent*)component getObjectArray]);
            }
            if ([component isKindOfClass:[ITS_PickerViewComponent class]]) {
                NSLog(@"%@",[(ITS_PickerViewComponent*)component currentSelection]);
            }
            if ([component isKindOfClass:[ITS_DiagnosticComponent class]]) {
                if ([[(ITS_DiagnosticComponent*)component getObjectData] count] < 1) {
                    [component updateComponentStatus:UITextFieldStatusWarning withWarningMessage:@"Por favor insira um diagnóstico!"];
                    creationIsValid = NO;
                }
            }
            
        }
    }
    //if everything is valid, build the object and send it to the database
    if (creationIsValid) {
        NSArray* sections; //in case we have sections like in the attachments
        for (NSArray* array in self.dataArray) {
            for (ITS_BaseTextFieldComponent* component in array) {
                [buildingArray addObject:[component getObjectData]];
                if ([component isKindOfClass:[ITS_AttachmentComponent class]]) {
                    sections = [(ITS_AttachmentComponent*)component getSections];
                }
            }
        }
        [self.viewModel buildObjectWithType:self.addTypeSelection andWithArray:buildingArray andSections:sections andIsEditing:self.isEditing andOldObject:self.selectedObject];
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
    return [component getDefaultComponentHeight];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        self.fieldsTableView.scrollEnabled = (self.scrollView.contentOffset.y >= 200);
    }
    
    if (scrollView == self.fieldsTableView) {
        self.fieldsTableView.scrollEnabled = (self.fieldsTableView.contentOffset.y > 0);
    }
}

#pragma mark - Present Delegates

- (void)attachmentComponentDidTapAddAttachment:(ITS_AttachmentComponent *)attachmentComponent withDocumentPicker:(nonnull UIDocumentPickerViewController *)documentPicker {
    [self presentViewController:documentPicker animated:YES completion:nil];
}

- (void)diagnosticComponentDidTapAddDiagnostic:(ITS_DiagnosticComponent *)diagnosticComponent withDiagnosticViewController:(ITS_DiagnosticViewController *)diagnosticViewController {
    [self presentViewController:diagnosticViewController animated:YES completion:nil];
}

#pragma mark - ViewModel Delegate
- (void)addViewModel:(ITS_AddViewModel *)viewModel didFinishBuildingScreenArray:(NSArray *)dataArray andSectionArray:(NSArray *)sectionArray {
    self.sectionArray = sectionArray;
    self.dataArray = dataArray;
    double totalHeight = 0;
    for (NSArray* array in self.dataArray) {
        for (ITS_BaseTextFieldComponent* component in array) {
            totalHeight += [component getDefaultComponentHeight];
            NSLog(@"%f",[component getDefaultComponentHeight]);
        }
    }
    totalHeight += 175;
    self.tableViewHeight.constant = totalHeight;
    
    if (self.isEditing) {
        switch (self.addTypeSelection) {
            case MainMenuSelectionMedics:
                self.dataArray = [self.viewModel fillComponentsWithData:[(Medic *)self.selectedObject arrayWithFullData] andDataArray:self.dataArray andSectionArray:self.sectionArray];
                break;
            case MainMenuSelectionPatients:
                self.dataArray = [self.viewModel fillComponentsWithData:[(Patient*)self.selectedObject arrayWithFullData] andDataArray:self.dataArray andSectionArray:self.sectionArray];
                break;
            default:
                break;
        }
        [self.fieldsTableView reloadData];
    } else {
        [self.fieldsTableView reloadData];
    }
  
}
@end
