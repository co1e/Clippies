//
//  PasteImageDetailView.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 8/5/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "PasteImageDetailView.h"

@implementation PasteImageDetailView

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:sv];
    iv = [[UIImageView alloc] initWithFrame:sv.bounds];
    [sv addSubview:iv];
    sv.zoomScale = 1.0;
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return iv;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
}

@end
