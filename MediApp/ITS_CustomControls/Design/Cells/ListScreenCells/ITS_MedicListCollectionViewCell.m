//
//  ITS_MedicListCollectionViewCell.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 01/06/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_MedicListCollectionViewCell.h"
@interface ITS_MedicListCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UITableView *specialtiesTableView;

@property (nonatomic) NSMutableArray* specialtiesArray;
@property (nonatomic) Medic* medic;
@end
@implementation ITS_MedicListCollectionViewCell
- (IBAction)onEdit:(id)sender {
    id<MedicListCellDelegate> strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(cell:didTapEditOnMedic:)]) {
        [strongDelegate cell:self didTapEditOnMedic:self.medic];
    }
    
}
- (IBAction)onDelete:(id)sender {
}

- (void)awakeFromNib {
    [super awakeFromNib];
   [self initContainerView:[ITS_Colors patientListCellGradient]];
    
    NSString *cellID = @"listLabelOnlyCell";
    [self.specialtiesTableView registerNib:[UINib nibWithNibName:@"ITS_ListLabelOnlyTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
}

- (void)fillCellWithData:(id)data {
    Medic* medic = data;
    self.specialtiesTableView.delegate = self;
    self.specialtiesTableView.dataSource = self;
    self.medic = medic;
    self.specialtiesArray = [[NSMutableArray alloc] init];
    
    for (Specialty* specialty in medic.specialtiesArray) {
        [self.specialtiesArray addObject:specialty.specialtyName];
    }
    
    [self.specialtiesTableView reloadData];
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@",self.medic.firstNames,self.medic.lastNames];
    [self.nameLabel setText:fullName];
    NSString *phoneIconAndNumber = [NSString stringWithFormat:@"􀌿%@",self.medic.phoneNumber];
    [self.phoneLabel setText:phoneIconAndNumber];
    NSString *emailIconAndEmail = [NSString stringWithFormat:@"􀍕 %@",self.medic.email];
    [self.emailLabel setText:emailIconAndEmail];
    [self.addressLabel setText:medic.address];
}

#pragma mark - UITableView Delegate/Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return at least 1 to state there are no diseases and the patient is healthy
    return [self.specialtiesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"listLabelOnlyCell";
    ITS_ListLabelOnlyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.titleLabel setText:[self.specialtiesArray objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}

@end
