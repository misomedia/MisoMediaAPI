//
//  MisoApiComposersClient.m
//  MisoApiProject
//
//  Created by Chris Lavender on 12/15/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import "MisoApiComposersClient.h"
#import "MisoApiClient.h"

static NSString *composersPath = @"composers";

@implementation MisoApiComposersClient
// assigned
@synthesize delegate;

- (void)getComposerWithId:(NSNumber *)composer_id 
              andCallback:(void(^)(id))handler
{
    NSString *method = [composer_id stringValue];
    
    [self.delegate requestWithPath:composersPath 
                            method:method
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}

- (void)getComposersByLetterForInstrumentType:(NSNumber *)instrumentType 
                                  andCallback:(void(^)(id))handler;
{    
    NSDictionary *params = [NSDictionary dictionaryWithObject:instrumentType 
                                                       forKey:@"instrument_type_idx"];

    [self.delegate requestWithPath:composersPath 
                            method:@"letters"
                         getParams:params 
                        postParams:nil 
                       andCallback:handler];
}

- (void)searchComposersWithParameters:(NSDictionary *)params 
                             andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:composersPath 
                            method:nil 
                         getParams:params 
                        postParams:nil 
                       andCallback:handler];
}

@end
