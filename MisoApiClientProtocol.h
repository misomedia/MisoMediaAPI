//
//  MisoApiClientProtocol.h
//  MisoApiProject
//
//  Created by Chris Lavender on 12/12/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

/*
 This is a protocol for objects to communicate to the MisoApiClient
 The MisoApiClient is the delegate for a collection of sub-clients.
 Rather than define this in multiple headers, it is defined one time
 here in it's own header.
 */

#import <Foundation/Foundation.h>

@protocol MisoApiClientProtocol <NSObject>

- (void)requestWithPath:(NSString *)path 
                 method:(NSString *)method 
              getParams:(NSDictionary *)getParams
             postParams:(NSDictionary *)postParams
            andCallback:(void (^)(id))callback;
@end
