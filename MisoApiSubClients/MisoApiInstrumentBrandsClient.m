//
//  MisoApiInstrumentBrandsClient.m
//  MisoApiProject
//
//  Created by Chris Lavender on 12/16/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import "MisoApiInstrumentBrandsClient.h"
#import "MisoApiClient.h"

static NSString *instrumentBrandsPath = @"instrument-brands";

@implementation MisoApiInstrumentBrandsClient
// assigned
@synthesize delegate;

- (void)getInstrumentBrandWithId:(NSNumber *)instrumentBrandId 
                     andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:instrumentBrandsPath 
                            method:[instrumentBrandId stringValue]
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}

- (void)searchInstrumentBrandsWithParameters:(NSDictionary *)params 
                                 andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:instrumentBrandsPath 
                            method:nil 
                         getParams:params 
                        postParams:nil 
                       andCallback:handler];
}

@end
