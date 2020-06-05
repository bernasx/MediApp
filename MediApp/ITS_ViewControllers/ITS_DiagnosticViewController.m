//
//  ITS_DiagnosticViewController.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 22/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_DiagnosticViewController.h"
#import "ITS_Enums.h"
@interface ITS_DiagnosticViewController ()
@property (nonatomic) NSArray* dataArray; //contains all data for building components
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (nonatomic) NSArray* sectionArray; //contains all section titles
@end

@implementation ITS_DiagnosticViewController
- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onSave:(id)sender {
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
           [self.viewModel buildDiagnosticObject:buildingArray withSections:sections];
       }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[ITS_DiagnosticViewModel alloc] init];
    self.viewModel.delegate = self;
    [self.saveButton setTintColor:[ITS_Colors primaryColor]];
    [self.cancelButton setTintColor:[ITS_Colors primaryColor]];
    NSString *cellID = @"addTableViewCell";
    [self.fieldsTableView registerNib:[UINib nibWithNibName:@"ITS_AddTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    [self.viewModel buildScreen];
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

#pragma mark - ViewModel Delegate
- (void)diagnosticViewModel:(ITS_DiagnosticViewModel *)viewModel didFinishBuildingScreenArray:(NSArray *)dataArray andSectionArray:(NSArray *)sectionArray {
    self.sectionArray = sectionArray;
    self.dataArray = dataArray;
    [self.fieldsTableView reloadData];
}

- (void)diagnosticViewModel:(ITS_DiagnosticViewModel *)viewModel didFinishBuildingDiagnostic:(Diagnostic *)diagnostic {
    id<DiagnosticViewControllerDelegate> strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(diagnosticViewController:didFinishDiagnostic:)]) {
        [strongDelegate diagnosticViewController:self didFinishDiagnostic:diagnostic];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)attachmentComponentDidTapAddAttachment:(ITS_AttachmentComponent *)attachmentComponent withDocumentPicker:(UIDocumentPickerViewController *)documentPicker {
     [self presentViewController:documentPicker animated:YES completion:nil];
}
@end
