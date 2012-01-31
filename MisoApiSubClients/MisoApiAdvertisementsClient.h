//
//  MisoApiAdvertisementsClient.h
//  MisoApiProject
//
//  Created by Chris Lavender on 12/15/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MisoApiClientProtocol.h"

@interface MisoApiAdvertisementsClient : NSObject

@property (nonatomic, assign) id<MisoApiClientProtocol> delegate;

- (void)getBannerAdvertisementsWithWidth:(NSNumber *)width 
                                   count:(NSNumber *)number 
                             andCallback:(void(^)(id))handler;

@end
