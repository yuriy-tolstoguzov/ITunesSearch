//
//  ESAlbum.h
//  ITunesSearch
//
//  Created by Yuru Taustahuzau on 2/12/14.
//  Copyright (c) 2014 EPAM Systems. All rights reserved.
//

#import <ROAD/ROADSerialization.h>


/**
 * We need to map class on web service response.
 * First we mark this class as serializable.
 */
RF_ATTRIBUTE(RFSerializable)
@interface ESAlbum : NSObject

/**
 * Then we mark all the properties we want to be serializable in this class.
 * And define serializationKey if necessary.
 * Good practice will be specifying serializationKey for every property.
 * In this case you can refactor property name later without fear.
 */
RF_ATTRIBUTE(RFSerializable, serializationKey = @"artworkUrl60")
@property NSString *artistName;

RF_ATTRIBUTE(RFSerializable, serializationKey = @"collectionName")
@property NSString *name;

RF_ATTRIBUTE(RFSerializable, serializationKey = @"collectionViewUrl")
@property NSString *viewURL;

RF_ATTRIBUTE(RFSerializable, serializationKey = @"artworkUrl60")
@property NSString *artworkURL;

RF_ATTRIBUTE(RFSerializable, serializationKey = @"collectionPrice")
@property NSNumber *price;

RF_ATTRIBUTE(RFSerializable)
@property NSString *currency;

/**
 * This property is just a composition of two previous. It won't be serialized.
 */
RF_ATTRIBUTE(RFDerived)
@property (readonly) NSString *priceLabel;

RF_ATTRIBUTE(RFSerializable)
@property NSNumber *trackCount;

/**
 * For serializing of dates we have efficient mechanism too. 
 * Just specify RFSerializableDate and its parameter you need.
 * Allocation of NSDateFormatter is pretty expansive operation, 
 * but if you use this property we will try to create as less as possible, and reuse as much as possible.
 */
RF_ATTRIBUTE(RFSerializable)
RF_ATTRIBUTE(RFSerializableDate, format = @"yyyy-MM-dd'T'HH:mm:ss'Z'")
@property NSDate *releaseDate;

@end
