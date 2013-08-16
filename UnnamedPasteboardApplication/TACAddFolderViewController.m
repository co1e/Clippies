//
//  TACAddFolderViewController.m
//  Clippings
//
//  Created by Thomas Cole on 8/13/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "TACAddFolderViewController.h"

@interface TACAddFolderViewController()
@property (nonatomic, strong) UILabel * folderNameLabel;
@property (nonatomic, strong) UITextField * folderName;
@end

@implementation TACAddFolderViewController
@synthesize folderNameLabel, folderName;
- (void)loadView
{
    folderNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    folderName = [[UITextField alloc] initWithFrame:CGRectZero];
    
    NSLayoutConstraint * folderNameLabelToFolderName = [[NSLayoutConstraint alloc] init];
}

@end
