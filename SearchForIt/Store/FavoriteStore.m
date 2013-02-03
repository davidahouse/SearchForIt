//
//  FavoriteStore.m
//  SearchForIt
//
//  Created by David House on 2/2/13.
//  Copyright (c) 2013 Random Accident. All rights reserved.
//

#import "FavoriteStore.h"

@implementation FavoriteStore

#pragma mark - Singleton method
+ (FavoriteStore *)sharedFavoriteStore {
    static FavoriteStore *sharedFavoriteStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFavoriteStore = [[self alloc] init];
    });
    return sharedFavoriteStore;
}

#pragma mark - Initializer
- (id)init {
    
    if ( self = [super init] ) {
        NSString *path = [self favoritePath];
        if ( [[NSFileManager defaultManager] fileExistsAtPath:path] ) {

            NSData *rawData = [NSData dataWithContentsOfFile:path];
            _favorites = [NSKeyedUnarchiver unarchiveObjectWithData:rawData];
        }
        else {
            _favorites = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

#pragma mark - Store Methods
- (void)saveFavorite:(id)favorite {
    
    [_favorites addObject:favorite];
    [self saveStore];
}

- (void)deleteFavorite:(id)favorite {
    
    [_favorites removeObject:favorite];
    [self saveStore];
}

- (NSArray *)favorites {
    
    return _favorites;
}

#pragma mark - Private Methods
- (NSString *)favoritePath {
    
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[directories objectAtIndex:0] stringByAppendingPathComponent:@"favorites.dat"];
}

- (void)saveStore {
    
    NSData *rawData = [NSKeyedArchiver archivedDataWithRootObject:_favorites];
    if ( ![rawData writeToFile:[self favoritePath] atomically:YES] ) {
        NSLog(@"error saving favorites file");
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:FAVORITE_STORE_CHANGED object:nil];
}

@end
