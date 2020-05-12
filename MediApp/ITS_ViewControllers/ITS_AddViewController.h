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
NS_ASSUME_NONNULL_BEGIN

@interface ITS_AddViewController : ITS_ViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *fieldsTableView;

@end

NS_ASSUME_NONNULL_END
