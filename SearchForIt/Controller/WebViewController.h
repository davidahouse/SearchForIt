//
//  WebViewController.h
//  SearchForIt
//
//  Created by David House on 2/2/13.
//  Copyright (c) 2013 Random Accident. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchResult;

@interface WebViewController : UIViewController {
}

#pragma mark - Properties
@property (nonatomic,retain) SearchResult *searchResult;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

#pragma mark - Actions
- (IBAction)saveAsFavorite:(id)sender;

@end
