//
//  SearchResult.m
//  Search
//
//  Created by David House on 12/27/12.
//  Copyright (c) 2012 Random Accident. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult

#pragma mark - Initializers
- (id)initWithResults:(id)JSON {
    if ( self = [super init] ) {
        _title = [JSON valueForKey:@"title"];
        _titleNoFormatting = [JSON valueForKey:@"titleNoFormatting"];
        _unescapedUrl = [JSON valueForKey:@"unescapedUrl"];
        _url = [JSON valueForKey:@"url"];
        _visibleUrl = [JSON valueForKey:@"visibleUrl"];
    }
    return self;
}

#pragma mark - NSCoding protocol
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_title forKey:@"title"];
    [encoder encodeObject:_titleNoFormatting forKey:@"titleNoFormatting"];
    [encoder encodeObject:_unescapedUrl forKey:@"unescapedUrl"];
    [encoder encodeObject:_url forKey:@"url"];
    [encoder encodeObject:_visibleUrl forKey:@"visibleUrl"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    if ( self = [super init] ) {
        _title = [decoder decodeObjectForKey:@"title"];
        _titleNoFormatting = [decoder decodeObjectForKey:@"titleNoFormatting"];
        _unescapedUrl = [decoder decodeObjectForKey:@"unescapedUrl"];
        _url = [decoder decodeObjectForKey:@"url"];
        _visibleUrl = [decoder decodeObjectForKey:@"visibleUrl"];
    }
    return self;
}

@end
