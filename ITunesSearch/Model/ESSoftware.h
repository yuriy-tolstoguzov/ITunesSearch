//
//  ESSoftware.h
//  ITunesSearch
//
//  Created by Yuru Taustahuzau on 2/12/14.
//  Copyright (c) 2014 EPAM Systems. All rights reserved.
//

#import <ROAD/ROADSerialization.h>


// Check out ESAlbum to see comments
RF_ATTRIBUTE(RFSerializable)
@interface ESSoftware : NSObject

RF_ATTRIBUTE(RFSerializable, serializationKey = @"trackName")
@property NSString *name;

RF_ATTRIBUTE(RFSerializable, serializationKey = @"artworkUrl60")
@property NSString *artworkURL;

RF_ATTRIBUTE(RFSerializable)
@property NSString *artistName;

RF_ATTRIBUTE(RFSerializable)
@property NSNumber *price;

RF_ATTRIBUTE(RFSerializable)
@property NSString *currency;

RF_ATTRIBUTE(RFDerived)
@property (readonly) NSString *priceLabel;

RF_ATTRIBUTE(RFSerializable, serializationKey = @"averageUserRating")
@property NSNumber *avgUserRating;

RF_ATTRIBUTE(RFSerializable, serializationKey = @"description")
@property NSString *appDescription;

RF_ATTRIBUTE(RFSerializable)
RF_ATTRIBUTE(RFSerializableDate, format = @"yyyy-MM-dd'T'HH:mm:ss'Z'")
@property NSDate *releaseDate;

@end
