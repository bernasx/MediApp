//
//  ITS_BaseTextFieldComponent.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 14/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ITS_BaseTextFieldComponent : UIView
- (id)getObjectData; //override this in any other component to grab ther respective relevant info
@end

NS_ASSUME_NONNULL_END
