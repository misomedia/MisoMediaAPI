//
//  MisoApiArrangementsClient.h
//  MisoApiProject
//
//  Created by Chris Lavender on 12/15/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MisoApiClientProtocol.h"

@interface MisoApiArrangementsClient : NSObject

@property (nonatomic, assign) id<MisoApiClientProtocol> delegate;

- (void)getFeaturedArrangementsForPageNumber:(NSNumber *)pageNumber
                                   itemCount:(NSNumber *)numberOfItems
                                 andCallback:(void (^)(id))handler;

- (void)getTopArrangementsForPageNumber:(NSNumber *)pageNumber
                              itemCount:(NSNumber *)numberOfItems
                            andCallback:(void (^)(id))handler;

- (void)getArrangementWithId:(NSNumber *)arrangement_id 
                 andCallback:(void(^)(id))handler;

- (void)getPartsForArrangementWithId:(NSNumber *)arrangement_id 
                         andCallback:(void(^)(id))handler;

- (void)searchArrangementsWithGetParameters:(NSDictionary *)getParams 
                                andCallback:(void(^)(id))handler;

@end
