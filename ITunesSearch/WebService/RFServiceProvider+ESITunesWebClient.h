//
//  RFServiceProvider+ESITunesWebClient.h
//  ITunesSearch
//
//  Created by Yuru Taustahuzau on 2/13/14.
//  Copyright (c) 2014 EPAM Systems. All rights reserved.
//

#import <ROAD/ROADServices.h>

#import "ESITunesWebClient.h"


/**
 * Here we adding new service to our service provider - iTunesWebClient.
 * In general case it's good practice to specify return type as id that conforms some protocol.
 * For the sake of simplicity we have strong typing.
 * Service that will be returned we specify in attribure as serviceClass
 */
@interface RFServiceProvider (ESITunesWebClient)

RF_ATTRIBUTE(RFService, serviceClass = [ESITunesWebClient class])
+ (ESITunesWebClient *)iTunesWebClient;

@end
