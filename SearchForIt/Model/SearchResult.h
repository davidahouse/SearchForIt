//
//  SearchResult.h
//  Search
//
//  Created by David House on 12/27/12.
//  Copyright (c) 2012 Random Accident. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResult : NSObject <NSCoding>

#pragma mark - Properties
@property (readonly) NSString *title;
@property (readonly) NSString *titleNoFormatting;
@property (readonly) NSString *unescapedUrl;
@property (readonly) NSString *url;
@property (readonly) NSString *visibleUrl;

#pragma mark - Initializers
- (id)initWithResults:(id)JSON;

@end
