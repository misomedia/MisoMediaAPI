//
//  MisoApiClient.h
//  MisoApiProject
//
//  Created by Chris Lavender on 12/9/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

/*
 The MisoApiClient is the request handling portion of the 
 API. It receives all elements of a request, constructs the 
 url, does a reachability check, and initiates the request.  
 It also recieves the response, converts the JSON data to an 
 NSDictionary, and does HTTP, JSON, and Miso API error checking.
 If an error is found, it is sent back to the requestor via
 the requestor's callback.
*/

#import <Foundation/Foundation.h>

#import "MisoApiClientProtocol.h"
#import "ErrorHandlerProtocol.h"

@class MisoApiAccountClient, MisoApiAdvertisementsClient, MisoApiArrangementsClient, MisoApiArtistsClient, MisoApiComposersClient,MisoApiInstrumentsClient, MisoApiInstrumentBrandsClient, MisoApiInstrumentSeriesClient, MisoApiPartsClient, MisoApiSongsClient,MisoApiBooksClient;

@interface MisoApiClient : NSObject <MisoApiClientProtocol>

@property (nonatomic, strong) id<ErrorHandlerProtocol> errorHandler;

@property (nonatomic, strong) NSString *api_key;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *auth_token;

@property (nonatomic, strong, readonly) MisoApiAccountClient            *accountClient;
@property (nonatomic, strong, readonly) MisoApiAdvertisementsClient     *advertisementsClient;
@property (nonatomic, strong, readonly) MisoApiArrangementsClient       *arrangementsClient;
@property (nonatomic, strong, readonly) MisoApiArtistsClient            *artistsClient;
@property (nonatomic, strong, readonly) MisoApiComposersClient          *composersClient;
@property (nonatomic, strong, readonly) MisoApiInstrumentsClient        *instrumentsClient;
@property (nonatomic, strong, readonly) MisoApiInstrumentBrandsClient   *instrumentBrandsClient;
@property (nonatomic, strong, readonly) MisoApiInstrumentSeriesClient   *instrumentSeriesClient;
@property (nonatomic, strong, readonly) MisoApiPartsClient              *partsClient;
@property (nonatomic, strong, readonly) MisoApiSongsClient              *songsClient;
@property (nonatomic, strong, readonly) MisoApiBooksClient              *booksClient;

+ (BOOL)internetIsReachable;
+ (MisoApiClient *) apiClient;

@end

// Category for NSDictionary to convert 
// key/values get params to NSString
@interface NSDictionary (UrlEncoding)
-(NSString*) urlEncodedString;
@end
