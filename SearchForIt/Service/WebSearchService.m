//
//  WebSearch.m
//  SearchForIt
//
//  Created by David House on 2/2/13.
//  Copyright (c) 2013 Random Accident. All rights reserved.
//

#import "WebSearchService.h"
#import "AFNetworking.h"
#import "SearchResult.h"

@implementation WebSearchService

#pragma mark - Search Methods
+ (void)searchFor:(NSString *)searchFor success:(void (^)(NSArray *results))success failure:(void (^)(NSError *error))failure {
    
    
    NSURLRequest *searchRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/web?v=1.0&rsz=8&q=%@",searchFor]]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:searchRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        NSLog(@"search returned: %@",JSON);
        NSLog(@"headers: %@",httpResponse.allHeaderFields);
        
        NSMutableArray *results = [[NSMutableArray alloc] init];
        id responseData = [JSON valueForKey:@"responseData"];
        if ( responseData ) {
            id resultArray = [responseData valueForKey:@"results"];
            for ( id resultItem in resultArray ) {
                SearchResult *searchResult = [[SearchResult alloc] initWithResults:resultItem];
                [results addObject:searchResult];
            }
        }
        
        if ( success ) {
            success(results);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error from search: %@",error);
        if ( failure ) {
            failure(error);
        }
    }];
    [operation start];
}

@end
