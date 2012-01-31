//
//  MisoApiPartsClient.h
//  MisoApiProject
//
//  Created by Chris Lavender on 12/9/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MisoApiClientProtocol.h"

@interface MisoApiPartsClient : NSObject

@property (nonatomic, assign) id<MisoApiClientProtocol> delegate;

- (void)getFeaturedPartsWithCallback:(void(^)(id))handler;

- (void)getPartWithId:(NSNumber *)part_id 
          andCallback:(void(^)(id))handler;

- (void)searchPartsWithParameters:(NSDictionary *)params 
                      andCallback:(void(^)(id))handler;

@end