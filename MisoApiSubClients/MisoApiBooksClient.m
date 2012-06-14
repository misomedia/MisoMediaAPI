//
//  MisoApiBooksClient.m
//  Sonata
//
//  Created by HEENA RASTOGI on 4/20/12.
//  Copyright (c) 2012 Miso Media. All rights reserved.
//

#import "MisoApiBooksClient.h"
static NSString *booksPath = @"books";             // HR -- Change the path to books after talking to web people

@implementation MisoApiBooksClient
// assigned
@synthesize delegate;
- (void)getFeaturedBooksForPageNumber:(NSNumber *)pageNumber
                            itemCount:(NSNumber *)numberOfItems
                          andCallback:(void (^)(id))handler
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            pageNumber, @"page",
                            numberOfItems, @"per_page",
                            nil];
    
    [self.delegate requestWithPath:booksPath 
                            method:@"featured" 
                         getParams:params 
                        postParams:nil 
                       andCallback:handler];

}

- (void)getTopBooksForPageNumber:(NSNumber *)pageNumber
                       itemCount:(NSNumber *)numberOfItems
                     andCallback:(void (^)(id))handler
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            pageNumber, @"page",
                            numberOfItems, @"per_page",
                            nil];
    
    [self.delegate requestWithPath:booksPath 
                            method:@"top" 
                         getParams:params 
                        postParams:nil 
                       andCallback:handler];

}

- (void)getScoresForBookWithId:(NSNumber *)bookId 
                   andCallback:(void (^)(id))handler;
{
    NSString *method = [NSString stringWithFormat:@"%@/arrangements",bookId];
    
    [self.delegate requestWithPath:booksPath 
                            method:method
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}

- (void)getBookWithId:(NSNumber *)book_id 
          andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:booksPath 
                            method:[book_id stringValue]
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}

- (void)searchBooksWithParameters:(NSDictionary *)params 
                      andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:booksPath 
                            method:nil 
                         getParams:params 
                        postParams:nil 
                       andCallback:handler];
}

@end
