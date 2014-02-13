//
//  ESStartViewController.m
//  ITunesSearch
//
//  Created by Yuru Taustahuzau on 2/12/14.
//  Copyright (c) 2014 EPAM Systems. All rights reserved.
//

#import "ESStartViewController.h"


@interface ESStartViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@end


@implementation ESStartViewController

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

static const NSInteger kRowSearchApps = 0;
static const NSInteger kRowLookupAlbums = 1;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * defaultCellIdentifier = @"defaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCellIdentifier];
    if (indexPath.row == kRowSearchApps) {
        cell.textLabel.text = @"Search apps by name";
    }
    else if (indexPath.row == kRowLookupAlbums) {
        cell.textLabel.text = @"Lookup albums by amg artist id";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == kRowSearchApps) {
        [self performSegueWithIdentifier:@"toSearch" sender:self];
    }
    else if (indexPath.row == kRowLookupAlbums) {
        [self performSegueWithIdentifier:@"toLookup" sender:self];
    }
}

@end
