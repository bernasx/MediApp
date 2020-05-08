//
//  ITS_CarroselCollectionView.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 08/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ITS_CarroselCollectionView : UICollectionView
- (NSInteger)itemCount;
- (UIImage *)imageAtIndex:(NSInteger)index;
- (NSString *)titleAtIndex:(NSInteger)index;
- (void)setUpArrays;
@end

NS_ASSUME_NONNULL_END
