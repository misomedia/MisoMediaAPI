//
//  MisoApiPartsClient.m
//  MisoApiProject
//
//  Created by Chris Lavender on 12/9/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import "MisoApiPartsClient.h"
#import "MisoApiClient.h"

static NSString *partsPath = @"song-parts";

@implementation MisoApiPartsClient
// assigned
@synthesize delegate;

- (void)getFeaturedPartsWithCallback:(void(^)(id))handler
{    
    [self.delegate requestWithPath:partsPath 
                            method:@"featured" 
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}

- (void)getPartWithId:(NSNumber *)part_id 
          andCallback:(void(^)(id))handler
{    
    [self.delegate requestWithPath:partsPath 
                            method:[part_id stringValue]
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}

- (void)searchPartsWithParameters:(NSDictionary *)params 
                      andCallback:(void(^)(id))handler
{    
    [self.delegate requestWithPath:partsPath 
                            method:@"expanded" 
                         getParams:params 
                        postParams:nil 
                       andCallback:handler];
}
@end
