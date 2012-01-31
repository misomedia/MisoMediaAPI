//
//  MisoApiAccountClient.h
//  MisoApiProject
//
//  Created by Chris Lavender on 12/18/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MisoApiClientProtocol.h"

static NSString *accountPath = @"account";

@interface MisoApiAccountClient : NSObject

@property (nonatomic, assign) id<MisoApiClientProtocol> delegate;

- (void)loginToAccountWithEmail:(NSString *)email 
                       password:(NSString *)password 
                    andCallback:(void(^)(id))handler;

//CL: this is a utility method for "special case" logins (facebook, old users, etc...)
- (void)loginToAccountWithPostParams:(NSDictionary *)params 
                         andCallback:(void(^)(id))handler;

- (void)logoutOfAccountWithCallback:(void(^)(id))handler;

- (void)registerAccountWithName:(NSString *)name
                          email:(NSString *)email
                  verifiedEmail:(NSString *)verifiedEmail
                       password:(NSString *)password 
               verifiedPassword:(NSString *)verifiedPassword
                    andCallback:(void(^)(id))handler;

- (void)changePasswordWithNewPassword:(NSString *)newPassword
                          andCallback:(void(^)(id))handler;

- (void)retrievePasswordForEmail:(NSString *)email 
                     andCallback:(void(^)(id))handler;

- (void)getAutoDownloadsWithCallback:(void(^)(id))handler;

- (void)editAccountNameWithString:(NSString *)name 
                      andCallback:(void(^)(id))handler;

- (void)retrievePartsForMigrationUsingArrangementIds:(NSArray *)arrangement_ids
                                         securityKey:(NSString *)key
                                         andCallback:(void(^)(NSArray *))handler;

- (void)getPurchasesWithCallback:(void(^)(id))handler;

- (void)getPurchasesById:(NSNumber *)purchase_id 
             andCallback:(void(^)(id))handler;

- (void)updatePurchaseById:(NSNumber *)purchase_id
     withAutoDownloadState:(NSNumber *)state 
               andCallback:(void(^)(id))handler;

- (void)getUpdatesForPastPurchasesOfParts:(NSArray *)part_ids 
                           andInstruments:(NSArray *)instrument_ids  
                             withCallback:(void(^)(id))handler;

- (void)recordPurchaseWithPostParams:(NSDictionary *)params
                         andCallback:(void(^)(id))handler;

- (void)recordMultiplePurchasesWithArray:(NSArray *)purchaseArray 
                             andCallback:(void(^)(id))handler;
@end
