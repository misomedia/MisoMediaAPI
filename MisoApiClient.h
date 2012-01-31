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

@class MisoApiAccountClient, MisoApiAdvertisementsClient, MisoApiArrangementsClient, MisoApiArtistsClient, MisoApiComposersClient,MisoApiInstrumentsClient, MisoApiInstrumentBrandsClient, MisoApiInstrumentSeriesClient, MisoApiPartsClient, MisoApiSongsClient;

@interface MisoApiClient : NSObject <MisoApiClientProtocol>

@property (nonatomic, retain) id<ErrorHandlerProtocol> errorHandler;

@property (nonatomic, retain) NSString *api_key;
@property (nonatomic, retain) NSString *version;
@property (nonatomic, retain) NSString *user_id;
@property (nonatomic, retain) NSString *auth_token;

@property (nonatomic, retain, readonly) MisoApiAccountClient            *accountClient;
@property (nonatomic, retain, readonly) MisoApiAdvertisementsClient     *advertisementsClient;
@property (nonatomic, retain, readonly) MisoApiArrangementsClient       *arrangementsClient;
@property (nonatomic, retain, readonly) MisoApiArtistsClient            *artistsClient;
@property (nonatomic, retain, readonly) MisoApiComposersClient          *composersClient;
@property (nonatomic, retain, readonly) MisoApiInstrumentsClient        *instrumentsClient;
@property (nonatomic, retain, readonly) MisoApiInstrumentBrandsClient   *instrumentBrandsClient;
@property (nonatomic, retain, readonly) MisoApiInstrumentSeriesClient   *instrumentSeriesClient;
@property (nonatomic, retain, readonly) MisoApiPartsClient              *partsClient;
@property (nonatomic, retain, readonly) MisoApiSongsClient              *songsClient;

+ (BOOL)internetIsReachable;

@end

// Category for NSDictionary to convert 
// key/values get params to NSString
@interface NSDictionary (UrlEncoding)
-(NSString*) urlEncodedString;
@end
