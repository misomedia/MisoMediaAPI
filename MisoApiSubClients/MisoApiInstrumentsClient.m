//
//  MisoApiInstrumentsClient.m
//  MisoApiProject
//
//  Created by Chris Lavender on 12/15/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import "MisoApiInstrumentsClient.h"
#import "MisoApiClient.h"

static NSString *instrumentsPath = @"instruments";

@implementation MisoApiInstrumentsClient
// assigned
@synthesize delegate;

- (void)getInstrumentWithId:(NSNumber *)instrument_id 
                andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:instrumentsPath 
                            method:[instrument_id stringValue]
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}

- (void)searchInstrumentsWithParameters:(NSDictionary *)params 
                            andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:instrumentsPath 
                            method:nil 
                         getParams:params 
                        postParams:nil 
                       andCallback:handler];
}

@end