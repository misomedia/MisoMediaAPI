//
//  MisoApiComposersClient.h
//  MisoApiProject
//
//  Created by Chris Lavender on 12/15/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MisoApiClientProtocol.h"

@interface MisoApiComposersClient : NSObject

@property (nonatomic, assign) id<MisoApiClientProtocol> delegate;

- (void)getComposerWithId:(NSNumber *)composer_id 
              andCallback:(void(^)(id))handler;

- (void)getComposersByLetterForInstrumentType:(NSNumber *)instrumentType 
                                  andCallback:(void(^)(id))handler;

- (void)searchComposersWithParameters:(NSDictionary *)params 
                          andCallback:(void(^)(id))handler;

@end