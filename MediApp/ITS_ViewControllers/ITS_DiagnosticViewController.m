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
@property (nonatomic) NSArray* sectionArray; //contains all section titles
@end

@implementation ITS_DiagnosticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[ITS_DiagnosticViewModel alloc] init];
    self.viewModel.delegate = self;
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
- (void)addViewModel:(ITS_DiagnosticViewModel *)viewModel didFinishBuildingScreenArray:(NSArray *)dataArray andSectionArray:(NSArray *)sectionArray{
    self.sectionArray = sectionArray;
    self.dataArray = dataArray;
//    double totalHeight = 0;
//    for (NSArray* array in self.dataArray) {
//        for (ITS_BaseTextFieldComponent* component in array) {
//            totalHeight += [component getDefaultComponentHeight];
//            NSLog(@"%f",[component getDefaultComponentHeight]);
//        }
//    }
//    totalHeight += 175;
//    self.tableViewHeight.constant = totalHeight;
    [self.fieldsTableView reloadData];
}

@end
