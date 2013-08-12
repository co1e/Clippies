//
//  PasteDetailView.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "PasteDetailView.h"
#import "Paste.h"

@interface PasteDetailView()

@property (nonatomic, strong) UITextView *tv;
@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) UIScrollView *sv;

@end

@implementation PasteDetailView
@synthesize tv, iv, paste, sv;

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    CGRect svContainer = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    CGRect tvContainer = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    CGRect ivContainer = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    sv = [[UIScrollView alloc] initWithFrame:svContainer];
    iv = [[UIImageView alloc] initWithFrame:ivContainer];
    tv = [[UITextView alloc] initWithFrame:tvContainer];
    
    iv.backgroundColor = [UIColor whiteColor];
    iv.contentMode = UIViewContentModeCenter;
    
    sv.delegate = self;
    sv.scrollEnabled = NO;
    
    sv.minimumZoomScale = 1.0;
    sv.maximumZoomScale = 5.0;
    
    [self.view addSubview:sv];
    [self.sv addSubview:tv];
    [self.sv addSubview:iv];
    
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return iv;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    scale = sv.zoomScale;
    view = self.view;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([paste.type isEqualToString:@"text"]) {
        [[self navigationItem] setTitle:@"Text"];
        tv.hidden = NO;
        [iv removeFromSuperview];
        tv.text = [[NSString alloc] initWithData:paste.data encoding:NSUTF8StringEncoding];
    }
    else if ([paste.type isEqualToString:@"image"]) {
        [[self navigationItem] setTitle:@"Image"];
        tv.hidden = YES;
        [tv removeFromSuperview];
        iv.image = [UIImage imageWithData:paste.data];
    }
}

- (void)setPaste:(Paste *)p
{
    paste = p;
}

- (void)savePaste
{
    NSString *string = [tv text];
    paste.data = [[NSData alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
