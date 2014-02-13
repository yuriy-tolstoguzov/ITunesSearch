//
//  ESLookupViewController.m
//  ITunesSearch
//
//  Created by Yuru Taustahuzau on 2/12/14.
//  Copyright (c) 2014 EPAM Systems. All rights reserved.
//

#import "ESLookupViewController.h"

#import "RFServiceProvider+ESITunesWebClient.h"
#import "ESLookupCell.h"
#import "ESArtist.h"
#import <ROAD/NSError+RFROADWebService.h>


@interface ESLookupViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *amgTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistGenreLabel;

@property (nonatomic) NSArray *albums;
@property (nonatomic) ESArtist *artist;
@property (weak, nonatomic) id<RFWebServiceCancellable> currentOperation;

- (IBAction)lookupAlbums:(id)sender;

@end


@implementation ESLookupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.amgTextField.text = @"468749"; // Initial value
    [self lookupAlbums:nil];
}

- (void)updateArtist:(ESArtist *)artist {
    self.artist = artist;
    self.artistNameLabel.text = self.artist.name;
    self.artistGenreLabel.text = self.artist.genre;
}


#pragma mark - IBActions

- (IBAction)lookupAlbums:(id)sender {
    [self.currentOperation cancel]; // Cancel last running operation if it exists. It force web client to execute failure block, so be sure that you handle it gracefully.
    __weak ESLookupViewController *weakSelf = self;
    self.currentOperation = [[RFServiceProvider iTunesWebClient] lookupAmgArtistId:self.amgTextField.text success:^(NSDictionary *albumsInfo) {// Here we have already processed entities, so we just save it and update UI
        ESLookupViewController *strongSelf = weakSelf;
        strongSelf.albums = albumsInfo[@"Albums"]; // In our custom serializer we put result into dictionary
        [strongSelf updateArtist:albumsInfo[@"Artist"]]; // And now we get these result with the same keys
        [strongSelf.tableView reloadData];
    } failure:^(NSError *error) {
        if ([error domain] != kRFWebServiceErrorDomain && weakSelf) { // kRFWebServiceErrorDomain - it's all errors from web service client, including cancel error, in your app check by code to get more precise filtration
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    }];
}


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *lookupCellIdentifier = @"lookupCellIdentifier";
    ESLookupCell *cell = [tableView dequeueReusableCellWithIdentifier:lookupCellIdentifier];
    [cell configureCellWithAlbum:self.albums[indexPath.row]];
    
    return cell;
}

@end
