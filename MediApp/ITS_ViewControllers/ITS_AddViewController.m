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
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic) NSArray* sectionArray; //contains all section titles
@end

@implementation ITS_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[ITS_AddViewModel alloc] init];
    self.viewModel.delegate = self; //delegate will ensure we get the data back 
    [self.viewModel buildScreen:self.addTypeSelection];//build the screen with textfields that represent what type of screen we're in
    
    //Setup for scrolling smoothly
    self.tableViewHeight.constant = 0;
    self.fieldsTableView.scrollEnabled = NO;
    self.scrollView.bounces = NO;
    self.fieldsTableView.bounces = YES;
    
    //setup button
    [self setupButtonTitle];
    [self.addButton setBackgroundColor:[ITS_Colors primaryColor]];
    [self.addButton.layer setCornerRadius:8];
    [self.addButton setClipsToBounds:YES];
    //button shadow
    [self.addButton.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [self.addButton.layer setShadowOffset:CGSizeMake(0, 2)];
    [self.addButton.layer setShadowRadius:4];
    [self.addButton.layer setShadowOpacity:0.8];
    [self.addButton.layer setMasksToBounds:NO];
}

- (void)setupButtonTitle {
    switch (self.addTypeSelection) {
        case MainMenuSelectionMedics:
            [self.addButton setTitle:@"Guardar Médico" forState:UIControlStateNormal];
            break;
        case MainMenuSelectionPatients:
            [self.addButton setTitle:@"Guardar Paciente" forState:UIControlStateNormal];
             break;
        case MainMenuSelectionAppointments:
            [self.addButton setTitle:@"Guardar Agendamento" forState:UIControlStateNormal];
             break;
        case MainMenuSelectionMedicalAppointment:
            [self.addButton setTitle:@"Guardar Consulta" forState:UIControlStateNormal];
             break;
        default:
            break;
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
    [self.viewModel buildObjectWithType:self.addTypeSelection andWithArray:buildingArray andSections:sections];
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

#pragma mark - Attachment Delegate

- (void)attachmentComponentDidTapAddAttachment:(ITS_AttachmentComponent *)attachmentComponent withDocumentPicker:(nonnull UIDocumentPickerViewController *)documentPicker {
    [self presentViewController:documentPicker animated:YES completion:nil];
}

#pragma mark - ViewModel Delegate
- (void)addViewModel:(ITS_AddViewModel *)viewModel didFinishBuildingScreenArray:(NSArray *)dataArray andSectionArray:(NSArray *)sectionArray{
    self.sectionArray = sectionArray;
    self.dataArray = dataArray;
    double totalHeight = 0;
    for (NSArray* array in self.dataArray) {
        for (ITS_BaseTextFieldComponent* component in array) {
            totalHeight += [component getDefaultComponentHeight] + 15;
            NSLog(@"%f",[component getDefaultComponentHeight]);
        }
    }
    self.tableViewHeight.constant = totalHeight;
    [self.fieldsTableView reloadData];
}
@end
