//
//  ESLookupCell.m
//  ITunesSearch
//
//  Created by Yuru Taustahuzau on 2/12/14.
//  Copyright (c) 2014 EPAM Systems. All rights reserved.
//

#import "ESLookupCell.h"


@implementation ESLookupCell

- (void)configureCellWithAlbum:(ESAlbum *)album {
    self.nameLabel.text = album.name;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    self.releaseDateLabel.text = [dateFormatter stringFromDate:album.releaseDate];
    self.priceLabel.text = album.priceLabel;
    self.trackCountLabel.text = [album.trackCount stringValue];
    self.artistLabel.text = album.artistName;
    
    __weak ESLookupCell *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURL * imageURL = [NSURL URLWithString:album.artworkURL];
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
