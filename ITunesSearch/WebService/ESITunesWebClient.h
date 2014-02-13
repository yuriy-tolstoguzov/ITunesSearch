//
//  ESITunesWebClient.h
//  ITunesSearch
//
//  Created by Yuru Taustahuzau on 2/12/14.
//  Copyright (c) 2014 EPAM Systems. All rights reserved.
//

#import <ROAD/ROADWebservice.h>
#import <ROAD/RFWebServiceSerializer.h>
#import "ESITunesLookupSerializer.h"
#import "ESSoftware.h"


RF_ATTRIBUTE(RFWebService, serviceRoot = @"https://itunes.apple.com")
@interface ESITunesWebClient : RFWebServiceClient

/**
 *  This request returns json response simular to https://itunes.apple.com/search?term=paper&entity=software&limit=10
 *  The request will be sent by default with GET method and enabled serialization
 *  We specifies that we want only results array and individual elements of this array should be serialized into ESSoftware
 */
RF_ATTRIBUTE(RFWebServiceCall, relativePath = @"/search?term=%%0%%&entity=software&limit=10", prototypeClass = [ESSoftware class], serializationRoot = @"results")
- (id<RFWebServiceCancellable>)searchAppsWithName:(NSString *)appName success:(void(^)(NSArray *apps))successBlock failure:(void(^)(NSError *error))failureBlock;;

/**
 * A bit more complex request in terms of serialization.
 * As you see in the example: https://itunes.apple.com/lookup?amgArtistId=468749,5723&entity=album 
 * there're two possible types of items in result array. This case does not have standard implementation, 
 * so we need to override default response serializer
 * (There's another possible solution - check out RFSerializationCustomHandler attribute).
 */
RF_ATTRIBUTE(RFWebServiceSerializer, serializerClass = [ESITunesLookupSerializer class])
RF_ATTRIBUTE(RFWebServiceCall, relativePath = @"/lookup?amgArtistId=%%0%%&entity=album", serializationRoot = @"results")
- (id<RFWebServiceCancellable>)lookupAmgArtistId:(NSString *)amgArtistId success:(void(^)(NSDictionary *albumsInfo))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
