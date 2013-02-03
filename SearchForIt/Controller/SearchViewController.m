//
//  SearchViewController.m
//  SearchForIt
//
//  Created by David House on 2/2/13.
//  Copyright (c) 2013 Random Accident. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResult.h"
#import "WebSearchService.h"
#import "WebViewController.h"

@implementation SearchViewController

#pragma mark - UIView
- (void)viewDidLoad {
    [super viewDidLoad];
    _searchResults = [NSArray array];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [WebSearchService searchFor:searchBar.text success:^(NSArray *results) {
        _searchResults = results;
        [self.searchDisplayController.searchResultsTableView reloadData];
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_searchResults count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    SearchResult *result = [_searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = result.titleNoFormatting;
    cell.detailTextLabel.text = result.visibleUrl;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    _selectedPath = indexPath;
    [self performSegueWithIdentifier:@"WebView" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    SearchResult *result = [_searchResults objectAtIndex:_selectedPath.row];
    WebViewController *wvc = (WebViewController *)segue.destinationViewController;
    wvc.searchResult = result;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

@end
