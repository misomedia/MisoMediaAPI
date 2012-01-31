//
//  MisoApiArtistsClient.h
//  MisoApiProject
//
//  Created by Chris Lavender on 12/15/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MisoApiClientProtocol.h"

@interface MisoApiArtistsClient : NSObject

@property (nonatomic, assign) id<MisoApiClientProtocol> delegate;

- (void)getArtistWithId:(NSNumber *)artist_id 
            andCallback:(void(^)(id))handler;

- (void)getArtistsByLetterWithParameters:(NSDictionary *)params  
                             andCallback:(void(^)(id))handler;

- (void)searchArtistsWithParameters:(NSDictionary *)params 
                        andCallback:(void(^)(id))handler;

@end