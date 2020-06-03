//
//  ITS_PatientListCollectionViewCell.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 26/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_PatientListCollectionViewCell.h"
@interface ITS_PatientListCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UITableView *diseasesTableView;
@property (nonatomic) Patient *patient;
@property (nonatomic) NSMutableArray *diseasesArray;
@end
@implementation ITS_PatientListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initContainerView:[ITS_Colors patientListCellGradient]];
    
    NSString *cellID = @"listLabelOnlyCell";
    [self.diseasesTableView registerNib:[UINib nibWithNibName:@"ITS_ListLabelOnlyTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
}


- (void)fillCellWithData:(id)data {
    Patient* patient = data;
    self.diseasesTableView.delegate = self;
    self.diseasesTableView.dataSource = self;
    self.patient = patient;
    self.diseasesArray = [[NSMutableArray alloc] init];
    
    for (Diagnostic* diagnostic in patient.diagnosticArray) {
        for (Disease* disease in diagnostic.currentDiseases) {
            [self.diseasesArray addObject:disease.diseaseName];
        }
    }
    [self.diseasesTableView reloadData];
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@",self.patient.firstNames,self.patient.lastNames];
    [self.nameLabel setText:fullName];
    [self.ageLabel setText:[NSString stringWithFormat:@"%d anos",self.patient.age]];
    NSString *phoneIconAndNumber = [NSString stringWithFormat:@"􀌿%@",self.patient.phoneNumber];
    [self.phoneNumberLabel setText:phoneIconAndNumber];
    
}

#pragma mark - UITableView Delegate/Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return at least 1 to state there are no diseases and the patient is healthy
    if ([self.diseasesArray count] < 1) {
        return 1;
    } else {
        return [self.diseasesArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"listLabelOnlyCell";
    ITS_ListLabelOnlyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ([self.diseasesArray count] < 1) {
        [cell.titleLabel setText:@"O paciente não tem doenças atualmente."];
    } else {
        [cell.titleLabel setText:[self.diseasesArray objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}

@end
