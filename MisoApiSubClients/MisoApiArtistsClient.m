//
//  MisoApiArtistsClient.m
//  MisoApiProject
//
//  Created by Chris Lavender on 12/15/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import "MisoApiArtistsClient.h"
#import "MisoApiClient.h"

static NSString *artistsPath = @"artists";

@implementation MisoApiArtistsClient
// assigned
@synthesize delegate;

- (void)getArtistWithId:(NSNumber *)artist_id 
            andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:artistsPath 
                            method:[artist_id stringValue]
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}


- (void)getArtistsByLetterWithParameters:(NSDictionary *)params  
                             andCallback:(void(^)(id))handler
{    
    [self.delegate requestWithPath:artistsPath 
                            method:@"letters"
                         getParams:params 
                        postParams:nil 
                       andCallback:handler];
}

- (void)searchArtistsWithParameters:(NSDictionary *)params 
                        andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:artistsPath 
                            method:nil 
                         getParams:params 
                        postParams:nil 
                       andCallback:handler];
}

@end
