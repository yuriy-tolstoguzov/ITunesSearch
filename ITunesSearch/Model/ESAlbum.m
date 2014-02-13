//
//  ESAlbum.m
//  ITunesSearch
//
//  Created by Yuru Taustahuzau on 2/12/14.
//  Copyright (c) 2014 EPAM Systems. All rights reserved.
//

#import "ESAlbum.h"


@implementation ESAlbum

- (NSString *)priceLabel {
    return [NSString stringWithFormat:@"%@ %@", self.price, self.currency];
}

@end
