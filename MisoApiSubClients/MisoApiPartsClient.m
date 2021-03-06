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

- (void)getFeaturedPartsForPageNumber:(NSNumber *)pageNumber
                            itemCount:(NSNumber *)numberOfItems
                          andCallback:(void (^)(id))handler
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            pageNumber, @"page",
                            numberOfItems, @"per_page",
                            nil];

    [self.delegate requestWithPath:partsPath 
                            method:@"featured" 
                         getParams:params 
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
