//
//  FavoriteStore.h
//  SearchForIt
//
//  Created by David House on 2/2/13.
//  Copyright (c) 2013 Random Accident. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FAVORITE_STORE_CHANGED @"FavoriteStoreChangedNotification"

@interface FavoriteStore : NSObject {
@private
    NSMutableArray *_favorites;
}

#pragma mark - Singleton
+ (FavoriteStore *)sharedFavoriteStore;

#pragma mark - Store Methods
- (void)saveFavorite:(id)favorite;
- (void)deleteFavorite:(id)favorite;
- (NSArray *)favorites;

@end
