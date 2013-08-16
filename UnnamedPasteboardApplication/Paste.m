//
//  Paste.m
//  Clippings
//
//  Created by Thomas Cole on 8/8/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "Paste.h"

@implementation Paste

@dynamic data;
@dynamic dateCreated;
@dynamic title;
@dynamic type;
@dynamic folder;
@dynamic group;

- (void)awakeFromFetch
{
    [super awakeFromFetch];
}

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    
    NSTimeInterval t = [[NSDate date] timeIntervalSinceReferenceDate];
    [self setDateCreated:t];
}
@end
