//
//  ErrorHandlerProtocol.h
//  MisoUIV3
//
//  Created by Chris Lavender on 1/19/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ErrorHandlerProtocol <NSObject>
- (void)handleError:(id)error;
@end
