//
//  ESSearchCell.m
//  ITunesSearch
//
//  Created by Yuru Taustahuzau on 2/12/14.
//  Copyright (c) 2014 EPAM Systems. All rights reserved.
//

#import "ESSearchCell.h"


@implementation ESSearchCell

- (void)configureCellWithApp:(ESSoftware *)app {
    self.nameLabel.text = app.name;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    self.releaseDateLabel.text = [dateFormatter stringFromDate:app.releaseDate];
    self.priceLabel.text = app.priceLabel;
    self.ratingLabel.text = [app.avgUserRating stringValue];
    self.developerLabel.text = app.artistName;
    
    __weak ESSearchCell *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURL * imageURL = [NSURL URLWithString:app.artworkURL];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage * image = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf setArtwork:image];
        });
    });
}

- (void)setArtwork:(UIImage *)artwork {
    [self.artworkImageView setImage:artwork];
}

@end
