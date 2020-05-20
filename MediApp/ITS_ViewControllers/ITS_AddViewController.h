//
//  ITS_AddViewController.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 11/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_ViewController.h"
#import "ITS_AddViewModel.h"
#import "ITS_AddTableViewCell.h"
#import "ITS_Enums.h"
#import "ITS_HeaderViewTableViewCell.h"
#import "ITS_TextFieldComponent.h"
#import "ITS_TextFieldWithTableComponent.h"
#import "ITS_PickerViewComponent.h"
#import "ITS_BaseTextFieldComponent.h"
#import "ITS_AttachmentComponent.h"
#import "Medic.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ITS_ZipCodeComponent.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_AddViewController : ITS_ViewController<UITableViewDelegate,UITableViewDataSource, AttachmentComponentDelegate,AddViewModelDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *fieldsTableView;
@property (nonatomic) MainMenuSelection addTypeSelection;
@end

NS_ASSUME_NONNULL_END
