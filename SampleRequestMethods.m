//
//  SampleRequestMethods.m
//  MisoApiProject
//
//  Created by Chris Lavender on 12/7/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import "SampleRequestMethods.h"

#import "MisoApiClient.h"
#import "User.h"
#import "Purchase.h"
#import "Advertisement.h"
#import "Arrangement.h"
#import "Artist.h"
#import "Composer.h"
#import "Instrument.h"
#import "InstrumentBrand.h"
#import "InstrumentSeries.h"
#import "Part.h"
#import "Song.h"


/*
 This class does nothing and should NOT be instantiated.
 It is simply here as a reference for creating requests

 Note that the below examples are generic. They are built
 so you can simply copy them from here, drop them where 
 you need to use them, and modify the completion block to 
 do something other than print an NSLog.
 
 In the case of the POST params requests (anything that
 takes an NSDictionary object) the key is "q" for a general 
 server search. However, any api key can be used for the 
 search key. For example, use the key "id" to search for an
 id. Or the key "artist" to search for an artist. Etc...
 
 IMPORTANT!
 If you want to call self inside a completion block DON'T!
 Rather create a weak pointer to self using the __block 
 keyword.
 
 for example: __block __typeof__(self)blockSelf = self;

 See Chris if this makes your brain hurt.
*/

@implementation SampleRequestMethods

#pragma mark- User Model Requests
- (void)loginToAccountWithEmail:(NSString *)email 
                    andPassword:(NSString *)password
{
    void (^requestorCallback)(NSString *, NSError *) = ^ (NSString * response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error) NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"%@",response);
        });
    };

    [[User staticUser] loginToAccountWithEmail:email 
                                      password:password
                                   andCallback:requestorCallback];
}

- (void)logoutOfAccount
{
    void (^requestorCallback)(NSString *, NSError *) = ^ (NSString * response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"logout of Account: %@",response);
        });
    };
    
    [[User staticUser] logoutOfAccountWithCallback:requestorCallback];
}

- (void)registerAccountWithName:(NSString *)name
                          email:(NSString *)email
                  verifiedEmail:(NSString *)verifiedEmail
                       password:(NSString *)password 
            andVerifiedPassword:(NSString *)verifiedPassword
{
    void (^requestorCallback)(NSString *, NSError *) = ^ (NSString * response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"%@",response);
        });
    };

    [[User staticUser] registerAccountWithName:name
                                         email:email
                                 verifiedEmail:verifiedEmail
                                      password:password 
                              verifiedPassword:verifiedPassword
                                   andCallback:requestorCallback];
}

- (void)changePasswordWithNewPassword:(NSString *)newPassword
{
    void (^requestorCallback)(NSString *, NSError *) = ^ (NSString * response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"%@",response);
        });
    };
    [[User staticUser] changePasswordWithNewPassword:newPassword 
                                         andCallback:requestorCallback];
}

- (void)retrievePasswordForEmail:(NSString *)email 
{
    void (^requestorCallback)(NSString *, NSError *) = ^ (NSString * response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"%@",response);
        });
    };
    [[User staticUser] retrievePasswordForEmail:email 
                                    andCallback:requestorCallback];

}

- (void)editAccountNameWithString:(NSString *)name
{
    void (^requestorCallback)(NSString *, NSError *) = ^ (NSString * response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"%@",response);
        });
    };

    [[User staticUser] editAccountNameWithString:name 
                                     andCallback:requestorCallback];
}

- (void)retrievePartsForMigrationUsingArrangementIds:(NSArray *)arrangement_ids
                                         securityKey:(NSString *)key
{
    void (^requestorCallback)(NSArray *, NSError *) = ^ (NSArray * parts, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"response: %@",parts);
        });
    };
    
    [[User staticUser] retrievePartsForMigrationUsingArrangementIds:arrangement_ids 
                                                        securityKey:key 
                                                        andCallback:requestorCallback];
}

#pragma mark- Purchase Model Requests
- (void)getAutoDownloads
{
    void (^requestorCallback)(id, NSError *) = ^ (id response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"AutoDownload: %@",response);
        });
    };

    [Purchase getAutoDownloadsWithCallback:requestorCallback];
}

- (void)getPastPurchases
{
    void (^requestorCallback)(NSArray *, NSError *) = ^ (NSArray *purchases, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Past Purchases: %@",purchases);
        });
    };
    
    [Purchase getPurchasesWithCallback:requestorCallback];
}

- (void)getPastPurchaseWithId:(NSNumber *)purchase_id 
{
    void (^requestorCallback)(Purchase *, NSError *) = ^ (Purchase *purchase, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Purchases with ID: %@",purchase);
        });
    };
    
     [Purchase getPurchasesById:purchase_id 
                    andCallback:requestorCallback];
}

- (void)updatePurchaseById:(NSNumber *)purchase_id
     withAutoDownloadState:(NSNumber *)state 
{
    void (^requestorCallback)(Purchase *, NSError *) = ^ (Purchase *purchase, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Updates Purchase by ID (AutoDownload): %@",purchase);
        });
    };
    
    [Purchase updatePurchaseById:purchase_id 
           withAutoDownloadState:state 
                     andCallback:requestorCallback];
}

- (void)getUpdatesForPastPurchasesOfParts:(NSArray *)part_ids 
                           andInstruments:(NSArray *)instrument_ids
{
    void (^requestorCallback)(NSError *) = ^ (NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        });
    };
    
    [Purchase getUpdatesForPastPurchasesOfParts:part_ids 
                                 andInstruments:instrument_ids
                                    withCallback:requestorCallback];
}

- (void)recordPurchaseWithItunesProductId:(NSString *)itunes_product_id 
                                   partId:(NSNumber *)part_id
                                    price:(NSDecimalNumber *)price 
                                   userId:(NSString *)user_id
                               andReceipt:(NSData *)receipt // CL: receipt will need to be encoded. Use the MisoNSStringCategory class method.
{
    void (^requestorCallback)(id, NSError *) = ^ (Purchase *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Purchase Item: %@",response);
        });
    };
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            user_id, @"user_id",
                            itunes_product_id, @"itunes_product_id", 
                            part_id, @"part_id", 
                            price, @"price",
                            receipt, @"receipt",
                            nil];
    
    [Purchase recordPurchaseWithPostParams:params 
                               andCallback:requestorCallback];
}


#pragma mark- Advertisement Model Requests
- (void)getBannerAdvertisementsWithWidth:(NSNumber *)width 
                                andCount:(NSNumber *)number 
{
    void (^requestorCallback)(NSArray *, NSError *) = ^ (NSArray *advertisements, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Advertisement Banners: %@",advertisements);
        });
    };
    
    [Advertisement getBannerAdvertisementsWithWidth:width 
                                              count:number 
                                        andCallback:requestorCallback];
}

#pragma mark- Arrangement Model Requests

- (void)getArrangementWithId:(NSNumber *)arrangementId 
{
    void (^requestorCallback)(Arrangement *, NSError *) = ^ (Arrangement *arrangement, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Arrangement: %@",arrangement);
        });
    };
    
    [Arrangement getArrangementWithId:arrangementId 
                          andCallback:requestorCallback];
}

- (void)getPartsForArrangementWithId:(NSNumber *)arrangement_id 
{
    void (^requestorCallback)(NSArray *, NSError *) = ^ (NSArray *parts, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Arrangement Parts: %@",parts);
        });
    };

    [Arrangement getPartsForArrangementWithId:arrangement_id 
                                  andCallback:requestorCallback];
}

- (void)searchForArrangements:(NSArray *)arrangement_ids
{
    void (^requestorCallback)(NSArray *, NSDictionary *, NSError *) = ^ (NSArray *arrangements, NSDictionary *pagination, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Arrangement Search results: %@, & Pagination: %@", arrangements, pagination);
        });
    };
    NSDictionary *params = [NSDictionary dictionaryWithObject:arrangement_ids forKey:@"id"];
    [Arrangement searchArrangementsWithParameters:params
                                      andCallback:requestorCallback];
}

#pragma mark- Artist Model Requests

- (void)getArtistWithId:(NSNumber *)artist_id 
{
    void (^requestorCallback)(Artist *, NSError *) = ^ (Artist *artist, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Artist by Id: %@",artist);
        });
    };
    
    [Artist getArtistWithId:artist_id 
                andCallback:requestorCallback];
}

- (void)getArtistsByLetterForInstrumentType:(NSString *)query
{
    void (^requestorCallback)(NSDictionary *, NSError *) = ^ (NSDictionary *artists, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Artists by Letter: %@",artists);
        });
    };
    // CL: like search, you can simply build whatever params you need.
    // the only difference is that this returns alphabetized.
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            query, @"q", 
                            nil];
        
    [Artist getArtistsByLetterWithParameters:params 
                                 andCallback:requestorCallback];
}

- (void)searchForArtists:(NSString *)query
{
    void (^requestorCallback)(NSArray *, NSError *) = ^ (NSArray *artists, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Artists Search Results: %@",artists);
        });
    };
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            query, @"q", 
                            nil];
    
    [Artist searchArtistsWithParameters:params 
                            andCallback:requestorCallback];
}

#pragma mark- Composer Model Requests
- (void)getComposerWithId:(NSNumber *)composer_id 
{
    void (^requestorCallback)(Composer *, NSError *) = ^ (Composer *composer, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Composer by Id: %@",composer);
        });
    };
    
    [Composer getComposerWithId:composer_id 
                    andCallback:requestorCallback];
}

- (void)getComposersByLetterForInstrumentType:(NSNumber *)instrumentType
{
    void (^requestorCallback)(NSDictionary *, NSError *) = ^ (NSDictionary *composers, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Composers by Letter: %@",composers);
        });
    };
    
    [Composer getComposersByLetterForInstrumentType:instrumentType 
                                        andCallback:requestorCallback];
}

- (void)searchForComposers:(NSString *)query forInstrumentType:(NSNumber *)instrumentType
{
    void (^requestorCallback)(NSArray *, NSError *) = ^ (NSArray *composers, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Composers Search Results: %@",composers);
        });
    };
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            instrumentType, @"instrument_type_idx", 
                            query, @"q", 
                            nil];
    
    [Composer searchComposersWithParameters:params 
                                andCallback:requestorCallback];
}

#pragma mark- Instrument Model Requests
- (void)getInstrumentWithId:(NSNumber *)instrument_id 
{
    void (^requestorCallback)(Instrument *, NSError *) = ^ (Instrument *instrument, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Instrument by Id: %@",instrument);
        });
    };
    
    [Instrument getInstrumentWithId:instrument_id 
                        andCallback:requestorCallback];
}

- (void)searchForInstruments:(NSString *)query forInstrumentType:(NSNumber *)instrumentType
{
    void (^requestorCallback)(NSArray *, NSDictionary *, NSError *) = ^ (NSArray *instruments, NSDictionary *pagination, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Instruments Array: %@ & Pagination: %@", instruments, pagination);
        });
    };
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            instrumentType, @"instrument_type_idx", 
                            query, @"q", 
                            nil];
    
    [Instrument searchInstrumentsWithParameters:params 
                                    andCallback:requestorCallback];

}

#pragma mark- InstrumentBrand Model Requests
- (void)getInstrumentBrandWithId:(NSNumber *)instrumentBrand_id 
{
    void (^requestorCallback)(InstrumentBrand *, NSError *) = ^ (InstrumentBrand *instrumentBrand, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error) {
                NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            }
            else NSLog(@"InstrumentBrand by Id: %@",instrumentBrand);
        });
    };
    
    [InstrumentBrand getInstrumentBrandWithId:instrumentBrand_id 
                                  andCallback:requestorCallback];
}

- (void)searchForInstrumentBrands:(NSString *)query
{
    void (^requestorCallback)(NSArray *, NSError *) = ^ (NSArray *instrumentBrands, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error) {
                NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            }
            else NSLog(@"Instruments Search Item: %@", instrumentBrands);
        });
    };
    NSDictionary *params = [NSDictionary dictionaryWithObject:query forKey:@"q"];
    
    [InstrumentBrand searchInstrumentBrandsWithParameters:params 
                                              andCallback:requestorCallback];
    
}

#pragma mark- InstrumentSeries Model Requests
- (void)getInstrumentSeriesWithId:(NSNumber *)instrumentSeries_id 
{
    void (^requestorCallback)(InstrumentSeries *, NSError *) = ^ (InstrumentSeries *instrumentSeries, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error) {
                NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            }
            else NSLog(@"InstrumentSeries by Id: %@",instrumentSeries);
        });
    };
    
    [InstrumentSeries getInstrumentSeriesWithId:instrumentSeries_id 
                                    andCallback:requestorCallback];
}

- (void)searchForInstrumentSeries:(NSString *)query
{
    void (^requestorCallback)(NSArray *, NSError *) = ^ (NSArray *instrumentSeries, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error) {
                NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            }
            else NSLog(@"Instruments Search Item: %@", instrumentSeries);
        });
    };
    NSDictionary *params = [NSDictionary dictionaryWithObject:query forKey:@"q"];
    
    [InstrumentSeries searchInstrumentSeriesWithParameters:params 
                                               andCallback:requestorCallback];
    
}

#pragma mark- Part Model Requests
- (void)getFeaturedParts
{   
    void (^requestorCallback)(NSArray *, NSError *) = ^ (NSArray *featuredParts, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error)NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Featured Stuff: %@",featuredParts);
        });
    };

    [Part getFeaturedPartsWithCallback:requestorCallback];
}

- (void)getPartWithId:(NSNumber *)part_id
{
    void (^requestorCallback)(Part *, NSError *) = ^ (Part *part, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error) NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Part Item: %@",part);
        });
    };
    
    [Part getPartWithId:part_id 
            andCallback:requestorCallback];
}

- (void)searchForParts:(id)query
{        
    void (^requestorCallback)(NSArray *, NSDictionary *, NSError *) = ^ (NSArray *parts, NSDictionary *pagination, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error) NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Parts Array: %@, Pagination: %@", parts, pagination);
        });
    };
    
    NSDictionary *params = nil;
    
    if ([query isKindOfClass:[NSString class]]) {
        params = [NSDictionary dictionaryWithObject:query forKey:@"q"];
    }
    else if ([query isKindOfClass:[NSArray class]])
    {
        params = [NSDictionary dictionaryWithObject:query forKey:@"id"];
    }
    
    [Part searchPartsWithParameters:params
                        andCallback:requestorCallback];
}

#pragma mark- Song Model Requests
- (void)getSongWithId:(NSNumber *)song_id 
{
    void (^requestorCallback)(Song *, NSError *) = ^ (Song *song, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error) NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Song by Id: %@",song);
        });
    };
    
    [Song getSongWithId:song_id 
            andCallback:requestorCallback];
}

- (void)searchForSongs:(NSString *)query
{
    void (^requestorCallback)(NSArray *, NSDictionary *,  NSError *) = ^ (NSArray *songs, NSDictionary *pagination, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Request complete. Do any necessary UI calls (i.e. stop an animating UIActivity Indicator)
            if (error) NSLog(@"Error:%@ // [%@ %@]", error.localizedDescription, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            else NSLog(@"Songs Search Results: %@, Pagination: %@",songs , pagination);
        });
    };
    NSDictionary *params = [NSDictionary dictionaryWithObject:query forKey:@"q"];
    
    [Song searchSongsWithParameters:params 
                        andCallback:requestorCallback];
}

@end
