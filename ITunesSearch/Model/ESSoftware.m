//
//  ESSoftware.m
//  ITunesSearch
//
//  Created by Yuru Taustahuzau on 2/12/14.
//  Copyright (c) 2014 EPAM Systems. All rights reserved.
//

#import "ESSoftware.h"


@implementation ESSoftware

- (NSString *)priceLabel {
    return [NSString stringWithFormat:@"%@ %@", self.price, self.currency];
}

@end
