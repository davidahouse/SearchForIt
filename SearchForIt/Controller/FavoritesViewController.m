//
//  FavoritesViewController.m
//  SearchForIt
//
//  Created by David House on 2/2/13.
//  Copyright (c) 2013 Random Accident. All rights reserved.
//

#import "FavoritesViewController.h"
#import "SearchResult.h"
#import "FavoriteStore.h"

@implementation FavoritesViewController

#pragma mark - UIView
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // load the initial array of favorites
    _favorites = [[FavoriteStore sharedFavoriteStore] favorites];
    
    // watch for any changes
    [[NSNotificationCenter defaultCenter] addObserverForName:FAVORITE_STORE_CHANGED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        _favorites = [[FavoriteStore sharedFavoriteStore] favorites];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_favorites count];
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
    
    SearchResult *result = [_favorites objectAtIndex:indexPath.row];
    cell.textLabel.text = result.titleNoFormatting;
    cell.detailTextLabel.text = result.visibleUrl;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        SearchResult *searchResult = [_favorites objectAtIndex:indexPath.row];
        [[FavoriteStore sharedFavoriteStore]deleteFavorite:searchResult];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
