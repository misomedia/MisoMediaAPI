//
//  MisoApiAccountClient.m
//  MisoApiProject
//
//  Created by Chris Lavender on 12/18/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import "MisoApiAccountClient.h"
#import "MisoApiClient.h"

@implementation MisoApiAccountClient
// assigned
@synthesize delegate;

- (void)loginToAccountWithEmail:(NSString *)email 
                       password:(NSString *)password 
                    andCallback:(void(^)(id))handler
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            email, @"email", 
                            password, @"password", 
                            nil];

    [self.delegate requestWithPath:accountPath 
                            method:@"login"
                         getParams:nil 
                        postParams:params 
                       andCallback:handler];
}

//CL: this is a utility method for "special case" logins (facebook, old users, etc...)
- (void)loginToAccountWithPostParams:(NSDictionary *)params 
                         andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:accountPath 
                            method:@"login"
                         getParams:nil 
                        postParams:params 
                       andCallback:handler];
}

- (void)logoutOfAccountWithCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:accountPath 
                            method:@"logout"
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}

- (void)registerAccountWithName:(NSString *)name
                          email:(NSString *)email
                  verifiedEmail:(NSString *)verifiedEmail
                       password:(NSString *)password 
               verifiedPassword:(NSString *)verifiedPassword
                    andCallback:(void(^)(id))handler
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                           name, @"name",
                           email, @"email",
                           verifiedEmail, @"email_verify",
                           verifiedPassword, @"password_verify",
                           password, @"password",
                           nil];

    [self.delegate requestWithPath:accountPath 
                            method:@"register"
                         getParams:nil 
                        postParams:params 
                       andCallback:handler];
}

//JH: this is a utility method for "special case" registration
- (void)registerAccountWithPostParams:(NSDictionary *)params 
                         andCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:accountPath 
                            method:@"register"
                         getParams:nil 
                        postParams:params 
                       andCallback:handler];
}

- (void)changePasswordWithNewPassword:(NSString *)newPassword
                          andCallback:(void(^)(id))handler
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            newPassword, @"password",
                            newPassword, @"password_verify",
                            nil];

    [self.delegate requestWithPath:accountPath 
                            method:@"change-password"
                         getParams:nil 
                        postParams:params 
                       andCallback:handler];
}

- (void)retrievePasswordForEmail:(NSString *)email 
                     andCallback:(void(^)(id))handler
{
    NSDictionary *params = [NSDictionary dictionaryWithObject:email 
                                                       forKey:@"email"];

    [self.delegate requestWithPath:accountPath 
                            method:@"forgot-password"
                         getParams:nil 
                        postParams:params 
                       andCallback:handler];
}

// GET AUTODOWNLOAD ITEMS
- (void)getAutoDownloadsWithCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:accountPath 
                            method:@"check-autodownload"
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}


- (void)editAccountNameWithString:(NSString *)name 
                      andCallback:(void(^)(id))handler
{
    NSDictionary *params = [NSDictionary dictionaryWithObject:name 
                                                       forKey:@"name"];

    [self.delegate requestWithPath:accountPath 
                            method:@"edit"
                         getParams:nil 
                        postParams:params 
                       andCallback:handler];
}

- (void)retrievePartsForMigrationUsingArrangementIds:(NSArray *)arrangement_ids
                                         securityKey:(NSString *)key
                                         andCallback:(void(^)(NSArray *))handler
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            arrangement_ids, @"arrangement_ids",
                            key, @"key",
                            nil];

    
    [self.delegate requestWithPath:accountPath 
                            method:@"migrations"
                         getParams:nil 
                        postParams:params 
                       andCallback:handler];
}

- (void)getPurchasesWithCallback:(void(^)(id))handler
{
    [self.delegate requestWithPath:accountPath 
                            method:@"purchases"
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}

- (void)getPurchasesById:(NSNumber *)purchase_id 
             andCallback:(void(^)(id))handler
{
    NSString *accountPurchasesMethod = [NSString stringWithFormat:@"purchases/%@",purchase_id];

    [self.delegate requestWithPath:accountPath 
                            method:accountPurchasesMethod
                         getParams:nil 
                        postParams:nil 
                       andCallback:handler];
}

- (void)updatePurchaseById:(NSNumber *)purchase_id
     withAutoDownloadState:(NSNumber *)state 
               andCallback:(void(^)(id))handler
{
    NSDictionary *params = [NSDictionary dictionaryWithObject:state 
                                                       forKey:@"is_autodownload"];

    NSString *accountPurchasesMethod = [NSString stringWithFormat:@"purchases/%@",purchase_id];

    [self.delegate requestWithPath:accountPath 
                            method:accountPurchasesMethod
                         getParams:nil 
                        postParams:params 
                       andCallback:handler];
}

- (void)getUpdatesForPastPurchasesOfParts:(NSArray *)part_ids 
                           andInstruments:(NSArray *)instrument_ids  
                             withCallback:(void(^)(id))handler
{    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            part_ids, @"song-parts", 
                            instrument_ids, @"instruments", 
                            nil];

    [self.delegate requestWithPath:accountPath 
                            method:@"purchases/updates"
                         getParams:params
                        postParams:nil 
                       andCallback:handler];
}

- (void)recordPurchaseWithPostParams:(NSDictionary *)params
                         andCallback:(void(^)(id))handler
{    
    [self.delegate requestWithPath:accountPath 
                            method:@"purchases"
                         getParams:nil 
                        postParams:params 
                       andCallback:handler];
}

- (void)recordMultiplePurchasesWithArray:(NSArray *)purchaseArray 
                             andCallback:(void(^)(id))handler
{    
    NSMutableDictionary *mutableParams = [[NSMutableDictionary alloc]init];
    // CL: for each dictionary in the array
    for (int i = 0; i < [purchaseArray count]; i++) {
        // CL: get the purchase data
        NSDictionary *purchase = [purchaseArray objectAtIndex:i];
        // CL: get the keys
        NSArray *keys = [purchase allKeys];
        for (NSString *key in keys) {
            // CL: format them and pack them in the new dictionary.
            NSString *newKey = [NSString stringWithFormat:@"purchase%d_%@", i, key];
            [mutableParams setValue:[purchase valueForKey:key] forKey:newKey];
        }
    }
    
    NSDictionary *params = [NSDictionary dictionaryWithDictionary:mutableParams];
    [mutableParams release];
    
    [self.delegate requestWithPath:accountPath 
                            method:@"purchases"
                         getParams:nil 
                        postParams:params 
                       andCallback:handler];
}

@end
