//
//  ITS_BaseListCollectionViewCell.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 26/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_BaseListCollectionViewCell.h"

@implementation ITS_BaseListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)fillCellWithData:(id)data {
    
}


- (void)initContainerView:(CAGradientLayer *)gradient {
    CAGradientLayer *gradientLayer = gradient;
    gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.containerView.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)layoutSubviews {
    self.contentView.layer.cornerRadius = 10.0f;
      self.contentView.layer.borderWidth = 1.0f;
      self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
      self.contentView.layer.masksToBounds = YES;

      self.layer.shadowColor = [UIColor blackColor].CGColor;
      self.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
      self.layer.shadowRadius = 5.0f;
      self.layer.shadowOpacity = 0.5f;
      self.layer.masksToBounds = NO;
      self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius].CGPath;
      self.layer.backgroundColor = [UIColor clearColor].CGColor;
}
@end
