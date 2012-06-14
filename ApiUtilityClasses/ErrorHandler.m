//
//  ErrorHandler.m
//  MisoUIV3
//
//  Created by Chris Lavender on 1/19/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "ErrorHandler.h"
//#import "User.h"

@interface ErrorHandler () 
@property (nonatomic, retain) NSArray *errorCodesArray;
@end

@implementation ErrorHandler
@synthesize errorCodesArray =_errorCodesArray;

- (void)dealloc 
{
    [_errorCodesArray release];
    
    [super dealloc];
}

- (void)handleError:(id)error
{
    if ([error isKindOfClass:[NSNumber class]]) {
        // CL: the plist entries are one less than the error codes.
         /*
        int errorIndex = [error intValue] - 1;
        
        NSDictionary *plistError = [self.errorCodesArray objectAtIndex:errorIndex];
        
        if ([[plistError objectForKey:@"Action"] isEqualToNumber:[NSNumber numberWithInt:1]])
        {
           
            // CL: maybe this should be changed to send a message to a VC?
            UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Oops!" 
                                                            message:[plistError objectForKey:@"DisplayMsg"]
                                                           delegate:nil 
                                                  cancelButtonTitle:@"Ok" 
                                                  otherButtonTitles: nil];
            [Alert show];
            [Alert release];
             
        }
          */
     //   [[User staticUser] resetUserData:nil];
    }
}

#pragma mark- Setter/Getter Overrides
- (NSArray *)errorCodesArray
{
    if (!_errorCodesArray) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ErrorCodes_List" ofType:@"plist"];
        NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        _errorCodesArray = [[NSArray alloc] initWithArray:[plistDictionary objectForKey:@"errCodesArr"]];
    }
    return _errorCodesArray;
}

@end
