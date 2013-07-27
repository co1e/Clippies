//
//  PasteDetailView.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "PasteDetailView.h"

@implementation PasteDetailView

- (id)init {
    self = [super init];
    if (self) {
        CGRect tvContainer = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        UITextView *tv = [[UITextView alloc] initWithFrame:tvContainer];
        tv.text = @"Test";
        [[self view] addSubview:tv];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

@end
