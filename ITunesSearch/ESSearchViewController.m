//
//  ESSearchViewController.m
//  ITunesSearch
//
//  Created by Yuru Taustahuzau on 2/12/14.
//  Copyright (c) 2014 EPAM Systems. All rights reserved.
//

#import "ESSearchViewController.h"

#import "RFServiceProvider+ESITunesWebClient.h"
#import "ESSearchCell.h"
#import <ROAD/NSError+RFROADWebService.h>


@interface ESSearchViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (nonatomic) NSArray *apps;
@property (weak, nonatomic) id<RFWebServiceCancellable> currentOperation; // Saved reference to current web client operation. We don't want to keep it after operation will finish, so we mark this property with weak attribute.

- (IBAction)searchApps:(id)sender;

@end


@implementation ESSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.searchTextField.text = @"SEC"; // Initail value
    [self searchApps:nil];
}


#pragma mark - IBActions

- (IBAction)searchApps:(id)sender {
    [self.currentOperation cancel]; // Cancel last running operation if it exists. It force web client to execute failure block, so be sure that you handle it gracefully.
    __weak ESSearchViewController *weakSelf = self;
    self.currentOperation = [[RFServiceProvider iTunesWebClient] searchAppsWithName:self.searchTextField.text success:^(NSArray *apps) {// Here we have already processed entities, so we just save it and update UI
        ESSearchViewController *strongSelf = weakSelf;
        strongSelf.apps = apps;
        [strongSelf.tableView reloadData];
    } failure:^(NSError *error) {
        if ([error domain] != kRFWebServiceErrorDomain && weakSelf) { // kRFWebServiceErrorDomain - it's all errors from web service client, including cancel error, in your app check by code to get more precise filtration
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    }];
}


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.apps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *searchCellIdentifier = @"searchCellIdentifier";
    ESSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:searchCellIdentifier];
    [cell configureCellWithApp:self.apps[indexPath.row]];
    
    return cell;
}

@end
