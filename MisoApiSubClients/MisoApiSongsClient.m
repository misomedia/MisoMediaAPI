//
//  MisoApiSongsClient.m
//  MisoApiProject
//
//  Created by Chris Lavender on 12/15/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import "MisoApiSongsClient.h"
#import "MisoApiClient.h"

static NSString *songsPath = @"songs";

@implementation MisoApiSongsClient
// assigned
@synthesize delegate;

- (void)getSongWithId:(NSNumber *)song_id 
          andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:songsPath 
                            method:[song_id stringValue]
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}

- (void)searchSongsWithParameters:(NSDictionary *)params 
                      andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:songsPath 
                            method:nil 
                         getParams:params 
                        postParams:nil 
                       andCallback:handler];
}

@end
