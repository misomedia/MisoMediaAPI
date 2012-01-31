//
//  MisoApiInstrumentSeriesClient.m
//  MisoApiProject
//
//  Created by Chris Lavender on 12/16/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import "MisoApiInstrumentSeriesClient.h"
#import "MisoApiClient.h"

static NSString *instrumentSeriesPath = @"instrument-series";

@implementation MisoApiInstrumentSeriesClient
// assigned
@synthesize delegate;

- (void)getInstrumentSeriesWithId:(NSNumber *)instrumentSeriesId 
                      andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:instrumentSeriesPath 
                            method:[instrumentSeriesId stringValue]
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}

- (void)searchInstrumentSeriesWithParameters:(NSDictionary *)params 
                                 andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:instrumentSeriesPath 
                            method:nil 
                         getParams:params 
                        postParams:nil 
                       andCallback:handler];
}

@end
