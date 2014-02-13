//
//  ESITunesLookupSerializer.m
//  ITunesSearch
//
//  Created by Yuru Taustahuzau on 2/12/14.
//  Copyright (c) 2014 EPAM Systems. All rights reserved.
//

#import "ESITunesLookupSerializer.h"

#import <ROAD/ROADSerialization.h>
#import "ESArtist.h"
#import "ESAlbum.h"


@implementation ESITunesLookupSerializer

/**
 * In this particular example we don't need any action here. 
 * We just don't pass any object to serialize in request method.
 */
- (NSString *)serializeObject:(id)object {
    return [object description];
}

/**
 * We need to separate artist entity from album entities.
 * Then deserialize them and pass to sender.
 */
- (id)deserializeData:(NSData *)data serializatinRoot:(NSString *)serializationRoot withDeserializationClass:(Class)deserializationClass error:(NSError *__autoreleasing *)error {
    // We want to parse data with standard serialization and then map it onto our object
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
    NSArray *results = responseDictionary[serializationRoot];
    
    NSDictionary *artist;
    NSUInteger albumsCount = [results count] ? [results count] - 1 : 0;
    NSMutableArray *albums = [[NSMutableArray alloc] initWithCapacity:albumsCount];
    
    // Go throught result and separate different type of objects
    for (NSDictionary *result in results) {
        if ([@"artist" isEqualToString:result[@"wrapperType"]]) {
            // We found our artist
            artist = result;
        }
        else if ([@"collection" isEqualToString:result[@"wrapperType"]]
                 && [@"Album" isEqualToString:result[@"collectionType"]]) {
            [albums addObject:result];
        }
    }

    // Direct interface for mapping dictionary on model class will be exposed soon.
    // Now we have to use small workaround to use our decoder to map these pieces to model classes.
    ESArtist *deserializedArtist = artist ? [RFAttributedDecoder decodeJSONData:[NSJSONSerialization dataWithJSONObject:artist options:0 error:error] withRootClassNamed:NSStringFromClass([ESArtist class])] : [[ESArtist alloc] init];
    NSArray *deserializedAlbums = [RFAttributedDecoder decodeJSONData:[NSJSONSerialization dataWithJSONObject:albums options:0 error:error] withRootClassNamed:NSStringFromClass([ESAlbum class])];
    
    // Return it as a dictionary with predefined keys.
    return @{@"Artist" : deserializedArtist,
             @"Albums" : deserializedAlbums};
}

@end
