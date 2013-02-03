//
//  WebViewController.m
//  SearchForIt
//
//  Created by David House on 2/2/13.
//  Copyright (c) 2013 Random Accident. All rights reserved.
//

#import "WebViewController.h"
#import "SearchResult.h"
#import "FavoriteStore.h"

@implementation WebViewController

#pragma mark - UIView
- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.searchResult.url]];
    [self.webView loadRequest:request];
}

#pragma mark - Actions
- (IBAction)saveAsFavorite:(id)sender {

    [[FavoriteStore sharedFavoriteStore] saveFavorite:self.searchResult];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Favorites" message:@"Favorite Saved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

@end
