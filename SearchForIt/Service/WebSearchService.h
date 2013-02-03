//
//  WebSearch.h
//  SearchForIt
//
//  Created by David House on 2/2/13.
//  Copyright (c) 2013 Random Accident. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebSearchService : NSObject

#pragma mark - Search Methods
+ (void)searchFor:(NSString *)searchTerm success:(void (^)(NSArray *results))success failure:(void (^)(NSError *error))failure;

@end
