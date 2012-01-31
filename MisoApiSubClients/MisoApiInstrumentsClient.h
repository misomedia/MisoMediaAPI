//
//  MisoApiInstrumentsClient.h
//  MisoApiProject
//
//  Created by Chris Lavender on 12/15/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MisoApiClientProtocol.h"

@interface MisoApiInstrumentsClient : NSObject

@property (nonatomic, assign) id<MisoApiClientProtocol> delegate;

- (void)getInstrumentWithId:(NSNumber *)instrument_id 
                andCallback:(void(^)(id))handler;

- (void)searchInstrumentsWithParameters:(NSDictionary *)params 
                            andCallback:(void(^)(id))handler;
@end
