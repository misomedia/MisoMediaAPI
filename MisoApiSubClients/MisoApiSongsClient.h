//
//  MisoApiSongsClient.h
//  MisoApiProject
//
//  Created by Chris Lavender on 12/15/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MisoApiClientProtocol.h"

@interface MisoApiSongsClient : NSObject

@property (nonatomic, assign) id<MisoApiClientProtocol> delegate;

- (void)getSongWithId:(NSNumber *)song_id 
          andCallback:(void(^)(id))handler;

- (void)searchSongsWithParameters:(NSDictionary *)params 
                         andCallback:(void(^)(id))handler;

@end
