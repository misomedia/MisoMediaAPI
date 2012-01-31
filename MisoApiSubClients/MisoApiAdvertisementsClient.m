//
//  MisoApiAdvertisementsClient.m
//  MisoApiProject
//
//  Created by Chris Lavender on 12/15/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import "MisoApiAdvertisementsClient.h"
#import "MisoApiClient.h"

static NSString *advertisementsPath = @"advertisements";

@implementation MisoApiAdvertisementsClient
// assigned
@synthesize delegate;

- (void)getBannerAdvertisementsWithWidth:(NSNumber *)width 
                                   count:(NSNumber *)number 
                             andCallback:(void(^)(id))handler
{
    NSString *bannerMethod = [NSString stringWithFormat:@"featured-store-banners/%@/%@",width,number];
    
    [self.delegate requestWithPath:advertisementsPath 
                            method:bannerMethod
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}
@end
