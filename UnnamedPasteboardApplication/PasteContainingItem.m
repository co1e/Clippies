//
//  PasteContainingItem.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "PasteContainingItem.h"

@implementation PasteContainingItem
@synthesize img, str;

- (id)init
{
    self = [super init];
    if (self) {
        [self setImage:[UIImage imageNamed:@"Placeholder.png"] withString:@""];
    }
    return self;
}

- (void)setStr:(NSString *)string
{
    [self setImage:nil withString:string];
}

- (void)setImg:(UIImage *)image
{
    [self setImage:image withString:nil];
}

- (void)setImage:(UIImage *)image withString:(NSString *)string
{
    img = image;
    string = string;
}

@end
