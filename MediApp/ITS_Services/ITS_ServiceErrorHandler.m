//
//  ITS_ErrorHandler.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_ServiceErrorHandler.h"
@interface ITS_ServiceErrorHandler()

@end

@implementation ITS_ServiceErrorHandler

//Override setter, as soon as an error is given the whole object updates.
- (void)setCurrentError:(NSError *)currentError {
    _currentError = currentError;
    [self checkStatusCode:self.currentError];
}

//check statuscode and call for an update to the error handler
- (void)checkStatusCode:(NSError *)error {
    if(error) {
        switch ([error code]) {
            case 17007:
                [self updateCurrentError:@"Este email já está em uso!" andWithIndexes:[NSArray arrayWithObjects:@"0", nil]];
                break;
            case 17008:
                [self updateCurrentError:@"Por favor insira um email válido." andWithIndexes:[NSArray arrayWithObjects:@"1", nil]];
                break;
            case 17009:
                [self updateCurrentError:@"Password incorreta" andWithIndexes:[NSArray arrayWithObjects:@"2", nil]];
                break;
            case 17011:
                [self updateCurrentError:@"Este email não existe." andWithIndexes:[NSArray arrayWithObjects:@"1", nil]];
                break;
            default:
                [self updateCurrentError:@"Erro" andWithIndexes:[NSArray arrayWithObjects:@"0", nil]];
                break;
        }
    }
}

//update the object with the new values
- (void)updateCurrentError:(NSString*)errorString andWithIndexes:(NSArray *)errorIndexes {
    self.errorString = errorString;
    self.errorIndexes = errorIndexes;
}

@end
