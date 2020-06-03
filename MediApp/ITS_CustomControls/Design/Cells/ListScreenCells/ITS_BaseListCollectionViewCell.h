//
//  ITS_BaseListCollectionViewCell.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 26/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITS_Colors.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_BaseListCollectionViewCell : UICollectionViewCell
@property (nonatomic,weak) IBOutlet UIView *containerView;
- (void)initContainerView:(CAGradientLayer *)gradient;
- (void)fillCellWithData:(id)data;
@end

NS_ASSUME_NONNULL_END
