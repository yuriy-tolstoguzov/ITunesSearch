//
//  ESArtist.h
//  ITunesSearch
//
//  Created by Yuru Taustahuzau on 2/12/14.
//  Copyright (c) 2014 EPAM Systems. All rights reserved.
//

#import <ROAD/ROADSerialization.h>


// Check out ESAlbum to see comments
RF_ATTRIBUTE(RFSerializable)
@interface ESArtist : NSObject

RF_ATTRIBUTE(RFSerializable, serializationKey = @"artistName")
@property NSString *name;

RF_ATTRIBUTE(RFSerializable, serializationKey = @"primaryGenreName")
@property NSString *genre;

RF_ATTRIBUTE(RFSerializable, serializationKey = @"artistLinkUrl")
@property NSString *link;

@end
