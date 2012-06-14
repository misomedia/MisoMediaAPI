//
//  MisoApiBooksClient.h
//  Sonata
//
//  Created by HEENA RASTOGI on 4/20/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MisoApiClientProtocol.h"

@interface MisoApiBooksClient : NSObject
@property (nonatomic, assign) id<MisoApiClientProtocol> delegate;

- (void)getFeaturedBooksForPageNumber:(NSNumber *)pageNumber
                            itemCount:(NSNumber *)numberOfItems
                          andCallback:(void (^)(id))handler;

- (void)getTopBooksForPageNumber:(NSNumber *)pageNumber
                       itemCount:(NSNumber *)numberOfItems
                     andCallback:(void (^)(id))handler;

- (void)getScoresForBookWithId:(NSNumber *)bookId 
                   andCallback:(void (^)(id))handler;

- (void)getBookWithId:(NSNumber *)book_id 
          andCallback:(void(^)(id))handler;

- (void)searchBooksWithParameters:(NSDictionary *)params 
                      andCallback:(void(^)(id))handler;
@end
