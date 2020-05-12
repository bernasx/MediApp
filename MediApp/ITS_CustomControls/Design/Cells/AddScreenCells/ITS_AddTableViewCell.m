//
//  ITS_AddTableViewCell.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 11/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_AddTableViewCell.h"
@interface ITS_AddTableViewCell()

@end

@implementation ITS_AddTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
//Sets up the cell with the appropriate view type. Additionally, it gives it the frame that it should use.
- (void)setUpCellwithType:(TextFieldComponentType)textFieldComponentType andTitle:(NSString *)title andTextFieldType:(TextFieldType)textFieldType andSearchType:(SearchType)searchType andData:(NSArray*)dataArray andWidth:(CGFloat)width {
    
    switch (textFieldComponentType) {
        case TextFieldComponentTypeNormal:
            self.componentView = [[ITS_TextFieldComponent alloc] init];
            [(ITS_TextFieldComponent *)self.componentView initWithTitle:title andType:textFieldType andFrame:CGRectMake(0, 0, width, 110)];
            [(ITS_TextFieldComponent *)self.componentView setViewFrame]; //Call this after initializing the component to set the frame properly to work with cell and subviews
            break;
       case TextFieldComponentTypeTableView:
            self.componentView = [[ITS_TextFieldWithTableComponent alloc] init];
            [(ITS_TextFieldWithTableComponent *)self.componentView initWithTitle:title andType:textFieldType andSearchType:searchType andFrame:CGRectMake(0, 0, width, 315) andArray:dataArray];
            [(ITS_TextFieldWithTableComponent *)self.componentView setViewFrame]; //same as above
            break;
       case TextFieldComponentTypePickerView:
            self.componentView = [[ITS_PickerViewComponent alloc] init];
            [(ITS_PickerViewComponent *)self.componentView initWithTitle:title andFrame:CGRectMake(0, 0, width, 110) withDataArray:dataArray];
            [(ITS_PickerViewComponent *)self.componentView setViewFrame]; //same as above
            break;
        default:
            break;
    }

    //make sure everything is clickable
    [self setUserInteractionEnabled:YES];
    [self.contentView setUserInteractionEnabled:YES];
    [self.componentView setUserInteractionEnabled:YES];
    [self.contentView addSubview:self.componentView];

}
@end
