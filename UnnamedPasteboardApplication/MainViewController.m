//
//  MainViewController.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/29/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (id)init {
    self = [super init];
    
    if (self) {
        self.navigationItem.title = @"Pasties";
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.667 green:0.000 blue:0.000 alpha:1.000];
    
    CGRect nameLabelRect = CGRectMake(0, 100, self.view.bounds.size.width, 24);
    nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
    nameLabel.text = @"Pasties";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:24.0];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:nameLabel];
}

@end
