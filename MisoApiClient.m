//
//  MisoApiClient.m
//  MisoApiProject
//
//  Created by Chris Lavender on 12/9/11.
//  Copyright (c) 2011 Miso Media. All rights reserved.
//

#import "MisoApiClient.h"

#import "MisoApiAccountClient.h"
#import "MisoApiAdvertisementsClient.h"
#import "MisoApiArrangementsClient.h"
#import "MisoApiArtistsClient.h"
#import "MisoApiComposersClient.h"
#import "MisoApiInstrumentsClient.h"
#import "MisoApiInstrumentBrandsClient.h"
#import "MisoApiInstrumentSeriesClient.h"
#import "MisoApiPartsClient.h"
#import "MisoApiSongsClient.h"
#import "MisoApiBooksClient.h"

//#import "SBJson.h" //for < iOS 5
#import "Reachability.h"

#import "SonataHeader.h"
// CL: the error handler should be set externally. 
// But putting here for now.
#import "ErrorHandler.h"

#define _LogRequestParams_ 0

static NSString *misoBaseUrl = miso_api_url;

static const NSString *MisoApiErrorKey = @"MisoApiError"; // for retrieving miso api errors from NSError objects

@interface MisoApiClient()
{
    __block MisoApiClient *blockMisoApiClient;
}

- (BOOL)checkApiErrorCode:(id)incomingData error:(NSError **)anError;
- (void)sendRequestUsingNSURLConnectionWithURLRequest:(NSURLRequest *)request andCallback:(void (^)(id))handler;
// parser is only for < iOS 5
//@property (nonatomic, strong) SBJsonParser              *jsonParser;
@property (nonatomic, strong) NSOperationQueue          *opQueue;

@property (nonatomic, strong, readonly) NSDictionary    *userAuthData;
@end

@implementation MisoApiClient

@synthesize api_key                 = _api_key;
@synthesize version                 = _version;
@synthesize user_id                 = _user_id;
@synthesize auth_token              = _auth_token;

@synthesize userAuthData            = _userAuthData;

@synthesize opQueue                 = _opQueue;
//@synthesize jsonParser              = _jsonParser;
@synthesize errorHandler            = _errorHandler;

@synthesize accountClient           = _accountClient;
@synthesize advertisementsClient    = _advertisementsClient;
@synthesize arrangementsClient      = _arrangementsClient;
@synthesize artistsClient           = _artistsClient;
@synthesize composersClient         = _composersClient;
@synthesize instrumentsClient       = _instrumentsClient;
@synthesize instrumentBrandsClient  = _instrumentBrandsClient;
@synthesize instrumentSeriesClient  = _instrumentSeriesClient;
@synthesize partsClient             = _partsClient;
@synthesize songsClient             = _songsClient;
@synthesize booksClient             = _booksClient;


static MisoApiClient *apiClient;

+ (MisoApiClient *) apiClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiClient = [[MisoApiClient alloc] init];
        
        apiClient->blockMisoApiClient = apiClient;
    });
    return apiClient;
}

- (void)dealloc
{
    [_userAuthData  release];
//    [_jsonParser    release];
    [_opQueue       release];
    [_errorHandler  release];
    
    [_accountClient             release];
    [_advertisementsClient      release];
    [_arrangementsClient        release];
    [_artistsClient             release];
    [_composersClient           release];
    [_instrumentsClient         release];
    [_instrumentBrandsClient    release];
    [_instrumentSeriesClient    release];
    [_partsClient               release];
    [_songsClient               release];
        
    [super dealloc];
}

#pragma mark- MisoApiErrorChecking

- (BOOL)checkApiErrorCode:(id)incomingData error:(NSError **)anError 
{
    BOOL result = NO;
    
    if ([incomingData isKindOfClass:[NSDictionary class]]) 
    {
        // CL: It's a dictionary so check for an error code
        NSDictionary *responseDict = incomingData;
        NSNumber *apiErrorCode = [responseDict objectForKey:@"code"];
        
        if(apiErrorCode && anError != NULL)
        {
            int error = [apiErrorCode intValue];
            
            // JH: handle errors outside of the bounds of plist
            if (error > 0 && error <= 31)[self.errorHandler handleError:apiErrorCode];
                
            NSString *description = [incomingData objectForKey:@"error"];
        
            // Make and return custom domain error.
            NSArray *objArray = [NSArray arrayWithObjects:description, incomingData, nil];
            NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, MisoApiErrorKey , nil];
            NSDictionary *userDict = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
            *anError = [[[NSError alloc] initWithDomain:@"Miso API Error" code:[apiErrorCode intValue] userInfo:userDict] autorelease];
            
            result = YES;
        }
    }
    return result;
}


#pragma mark- Send Request Methods
- (void)sendRequestUsingNSURLConnectionWithURLRequest:(NSURLRequest *)request andCallback:(void (^)(id))handler
{
    __block __typeof__(self)blockSelf = self;
    
    // CL: build a block to be run asynchronously
    void (^handleResponse)(NSURLResponse *, NSData *, NSError *) = ^(NSURLResponse *response, NSData *data, NSError *error) {
        
        id results = nil;
        
        // CL: http errors would be caught here.
        if (error) {
            NSLog(@"[%@ %@] HTTP error: %@", NSStringFromClass([blockSelf class]), NSStringFromSelector(_cmd), error.localizedDescription);
            results = error;
        }
        else {
        // CL: parse the JSON
            if (data) {
                results = [NSJSONSerialization JSONObjectWithData:data 
                                                          options:NSJSONReadingMutableContainers 
                                                            error:&error];
            }
            else {
                results = nil;
            }
            // CL: json errors would be caught here.
            if (error) {
                NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([blockSelf class]), NSStringFromSelector(_cmd), error.localizedDescription);
                results = error;
            }
            
            // CL: Check for an Miso API errors.
            else if ([blockSelf checkApiErrorCode:results error:&error]) {
                //CL: if there's an error make the NSError object the result.
                if (error) results = error;
            }

        }
        // If no errors send result to the completion block
        handler(results);
    };

    [NSURLConnection sendAsynchronousRequest:request 
                                       queue:self.opQueue 
                           completionHandler:handleResponse];
}

#pragma mark- MisoApiClientProtocol Method Implementations
- (void)requestWithPath:(NSString *)path 
                 method:(NSString *)method 
              getParams:(NSDictionary *)getParams 
             postParams:(NSDictionary *)postParams 
            andCallback:(void (^)(id))handler
{
    NSMutableDictionary *combinedParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           self.api_key, @"api_key", 
                                           self.version, @"version", 
                                           self.user_id, @"user_id", 
                                           self.auth_token, @"auth_token", 
                                           nil];
    
    [combinedParams addEntriesFromDictionary:getParams];
    
    NSString *pathString;
    if (method) pathString = [NSString stringWithFormat:@"/%@/%@.json?",path,method];
    else pathString = [NSString stringWithFormat:@"/%@.json?",path];

    NSString *paramString = [combinedParams urlEncodedString];
    
    // build the complete url using stringWithFormat:"
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", misoBaseUrl, pathString, paramString];
    NSURL *url          = [NSURL URLWithString:urlString];  
    
    NSURLRequest *request;
    if (postParams) 
    {
        NSString *post          = [postParams urlEncodedString];
        NSData *postData        = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength    = [NSString stringWithFormat:@"%d", [postData length]];
        
#if _LogRequestParams_
        NSLog(@"Post Params: %@", post);
#endif
        
        NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
        [postRequest setHTTPMethod:@"POST"];
        [postRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [postRequest setHTTPBody:postData];
        
        request = postRequest;
    }
    else 
    {
        request   = [NSURLRequest requestWithURL:url];
    }
    
#if _LogRequestParams_
    NSLog(@"Path: %@", path);
    NSLog(@"Method: %@", method);
    NSLog(@"Combined Params: %@", combinedParams);
    NSLog(@"Url String: %@", urlString);
#endif
    
    // CL: Since we currently have two different request options (pre/post iOS 5) check for Reachability HERE!
    if ([[self class] internetIsReachable]) 
    {
        if ([[NSURLConnection class] respondsToSelector:@selector(sendAsynchronousRequest:queue:completionHandler:)]) 
        {
            [self sendRequestUsingNSURLConnectionWithURLRequest:request andCallback:handler];
        }
    }
}

#pragma mark- Setter/Getter Overrides

// CL: the below errorHandler overrides is here temporarily
// should be set externally.
- (id)errorHandler
{
    if (!_errorHandler) {
        _errorHandler = [[ErrorHandler alloc]init];
    }
    return _errorHandler;
}

- (NSString *)api_key
{   
    if (!_api_key) {
        _api_key = [[NSString alloc]initWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MisoApiKey"]];
    }
    return _api_key;
}

- (NSString *)version
{
    if (!_version) {
        _version = [[NSString alloc] initWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];  
    }
    return _version;
}

- (NSOperationQueue *)opQueue
{
    if (!_opQueue) {
        _opQueue = [[NSOperationQueue alloc] init];
    }
    return _opQueue;
}

- (MisoApiAccountClient *)accountClient
{
    if (!_accountClient) {
        _accountClient = [[MisoApiAccountClient alloc]init];
        _accountClient.delegate = self;
    }
    return _accountClient;
}

- (MisoApiAdvertisementsClient *)advertisementsClient
{
    if (!_advertisementsClient) {
        _advertisementsClient = [[MisoApiAdvertisementsClient alloc]init];
        _advertisementsClient.delegate = self;
    }
    return _advertisementsClient;
}

- (MisoApiArrangementsClient *)arrangementsClient
{
    if (!_arrangementsClient) {
        _arrangementsClient = [[MisoApiArrangementsClient alloc]init];
        _arrangementsClient.delegate = self;
    }
    return _arrangementsClient;
}

- (MisoApiArtistsClient *)artistsClient
{
    if (!_artistsClient) {
        _artistsClient = [[MisoApiArtistsClient alloc]init];
        _artistsClient.delegate = self;
    }
    return _artistsClient;
}

- (MisoApiComposersClient *)composersClient
{
    if (!_composersClient) {
        _composersClient = [[MisoApiComposersClient alloc]init];
        _composersClient.delegate = self;
    }
    return _composersClient;
}

- (MisoApiInstrumentsClient *)instrumentsClient
{
    if (!_instrumentsClient) {
        _instrumentsClient = [[MisoApiInstrumentsClient alloc]init];
        _instrumentsClient.delegate = self;
    }
    return _instrumentsClient;
}

- (MisoApiInstrumentBrandsClient *)instrumentBrandsClient
{
    if (!_instrumentBrandsClient) {
        _instrumentBrandsClient = [[MisoApiInstrumentBrandsClient alloc]init];
        _instrumentBrandsClient.delegate = self;
    }
    return _instrumentBrandsClient;
}

- (MisoApiInstrumentSeriesClient *)instrumentSeriesClient
{
    if (!_instrumentSeriesClient) {
        _instrumentSeriesClient = [[MisoApiInstrumentSeriesClient alloc]init];
        _instrumentSeriesClient.delegate = self;
    }
    return _instrumentSeriesClient;
}

- (MisoApiPartsClient *)partsClient
{
    if (!_partsClient) {
        _partsClient = [[MisoApiPartsClient alloc]init];
        _partsClient.delegate = self;
    }
    return _partsClient;
}

- (MisoApiSongsClient *)songsClient
{
    if (!_songsClient) {
        _songsClient = [[MisoApiSongsClient alloc]init];
        _songsClient.delegate = self;
    }
    return _songsClient;
}

- (MisoApiBooksClient *)booksClient
{
    if (!_booksClient) {
        _booksClient = [[MisoApiBooksClient alloc]init];
        _booksClient.delegate = self;
    }
    return _booksClient;
}
#pragma mark- Reachability Methods
+ (BOOL)internetIsReachable 
{
    BOOL result = YES;
    
    Reachability *r = [Reachability reachabilityWithHostName:@"google.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    if(internetStatus == NotReachable)
    {
        // CL: maybe this should be changed to send a message to a VC?
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" 
                                                        message:@"You do not seem to have internet connectivity at this time. Please connect to the internet to use this feature." 
                                                       delegate:nil 
                                              cancelButtonTitle:@"Ok" 
                                              otherButtonTitles: nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LogOutFromShop" object:nil];
        
        [Alert show];
        [Alert release];
        
		result = NO;
    }
    return result;
}

@end




#pragma mark- NSDictionary API Specific Category Implementation

// helper function: get the string form of any object
static NSString *toString(id object) {
    return [NSString stringWithFormat: @"%@", object];
}

// helper function: get the url encoded string form of any object
static NSString *urlEncode(id object) {
    NSString *string = nil;
    
    // CL: if the Dictionary item is an Array of other objects
    // than we need to pull them out and prep them.
    // otherwise, the memory addresses are sent rather than the values
    if ([object isKindOfClass:[NSArray class]]) string = [object componentsJoinedByString:@","];
    else string = toString(object);
    
    NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                   (CFStringRef)string,
                                                                                   NULL,
                                                                                   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                   kCFStringEncodingUTF8);
    return [encodedString autorelease];
}

@implementation NSDictionary (UrlEncoding)

-(NSString *)urlEncodedString 
{
    NSMutableArray *parts = [NSMutableArray array];
    //NSArray* sortedKeys = [self keysSortedByValueUsingSelector:@selector(caseInsensitiveCompare:)];
    for (id key in self) 
    {
        id value = [self objectForKey:key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    [parts sortUsingSelector:@selector(caseInsensitiveCompare:)];
    return [parts componentsJoinedByString: @"&"];
}

@end