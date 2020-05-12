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
@property (nonatomic) NSMutableArray* dataArray;
@property (nonatomic) NSMutableArray* sectionArray;
@end

@implementation ITS_AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[ITS_AddViewModel alloc] init];
    [self designViewElements];
}

//eventually this will design the view based on what we're adding
- (void)designViewElements {
    
    self.dataArray = [NSMutableArray new];
    self.sectionArray = [NSMutableArray new];
    
    [self addSectionToArrayWithName:@"Dados Pessoais"];
    [self addSectionToArrayWithName:@"Dados Médicos"];
    
    [self addComponentToArrayAtSection:0 withArray:@[
        [NSNumber numberWithInt:TextFieldComponentTypeNormal],@"Primeiro Nome",[NSNumber numberWithInt:UITextFieldDefault],[NSNumber numberWithInt:SearchSpecialty],[NSArray new]]];
    //fetch specialties, init the view
    [self.viewModel fetchSpecialties:^(NSArray * _Nullable specialtiesArray) {
        [self addComponentToArrayAtSection:1 withArray: @[[NSNumber numberWithInt:TextFieldComponentTypeTableView],@"Especialidade",[NSNumber numberWithInt:UITextFieldSearch],[NSNumber numberWithInt:SearchSpecialty],specialtiesArray]];
        [self.fieldsTableView reloadData];
    }];
}

#pragma mark - array management

- (void)addSectionToArrayWithName:(NSString *)sectionName {
    [self.sectionArray addObject:sectionName];
    [self.dataArray addObject:[NSMutableArray new]];
}

- (void)addComponentToArrayAtSection:(NSInteger)section withArray:(NSArray *)component {
    [[self.dataArray objectAtIndex:section] addObject:component];
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
    NSArray *cellDataArray = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    //sets up the cell's textfield component. To be noted the actual frame given must be set in the AddTableViewCell
    [cell setUpCellwithType:[[cellDataArray objectAtIndex:0] intValue] andTitle:[cellDataArray objectAtIndex:1] andTextFieldType:[[cellDataArray objectAtIndex:2] intValue] andSearchType:[[cellDataArray objectAtIndex:3] intValue]andData:[cellDataArray objectAtIndex:4] andWidth:self.fieldsTableView.frame.size.width];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *tempArray = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];//array that actually holds the info for each cell
    switch ([[tempArray objectAtIndex:0] intValue]) {
        case TextFieldComponentTypeNormal:
            return 110;
            break;
        case TextFieldComponentTypeTableView:
            return 315;
            break;
        case TextFieldComponentTypePickerView:
            return 110;
            break;
        default:
            return 110;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
}


@end
