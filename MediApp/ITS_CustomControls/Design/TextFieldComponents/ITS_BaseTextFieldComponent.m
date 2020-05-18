//
//  ITS_BaseTextFieldComponent.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 14/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_BaseTextFieldComponent.h"

@implementation ITS_BaseTextFieldComponent

- (id)getObjectData {
    return @"Failed to retrieve object Data";
}

- (void)updateComponentStatus:(TextFieldStatus)textFieldStatus withWarningMessage:(NSString *)warningMessage{
    
}

- (CGFloat)getDefaultComponentHeight {
    return 110;
}

@end
