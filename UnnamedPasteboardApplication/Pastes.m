//
//  Pastes.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/29/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "Pastes.h"

@implementation Pastes

@dynamic dateCreated;
@dynamic imageKey;
@dynamic pasteID;
@dynamic stringData;
@dynamic urlData;
@dynamic relationship;

- (void)awakeFromFetch
{
    [super awakeFromFetch];
    
    
}

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    
    // After insert, set date created for item
    NSTimeInterval t = [[NSDate date] timeIntervalSinceReferenceDate];
    [self setDateCreated:t];
}

@end
