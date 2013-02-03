//
//  FavoritesViewController.h
//  SearchForIt
//
//  Created by David House on 2/2/13.
//  Copyright (c) 2013 Random Accident. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UIViewController {
@private
    NSArray *_favorites;
}

#pragma mark - Properties
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
