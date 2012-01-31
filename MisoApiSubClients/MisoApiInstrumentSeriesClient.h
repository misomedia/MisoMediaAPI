//
//  MisoApiInstrumentSeriesClient.h
//  MisoApiProject
//
//  Created by Chris Lavender on 12/16/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MisoApiClientProtocol.h"

@interface MisoApiInstrumentSeriesClient : NSObject

@property (nonatomic, assign) id<MisoApiClientProtocol> delegate;

- (void)getInstrumentSeriesWithId:(NSNumber *)instrumentSeriesId 
                      andCallback:(void(^)(id))handler;

- (void)searchInstrumentSeriesWithParameters:(NSDictionary *)params 
                                 andCallback:(void(^)(id))handler;
@end
