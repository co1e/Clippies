//
//  CustomPasteCell.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/30/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "CustomPasteCell.h"
#import "Paste.h"

@implementation CustomPasteCell
@synthesize textLabel;
@synthesize imageView;
@synthesize containerView;
//@synthesize copiedLabel;
//@synthesize dateCreatedLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, 8, self.bounds.size.width - 15, 60)];
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 15, 0, self.bounds.size.width - 15, 60)];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 15, 0, self.bounds.size.width - 15, 60)];

//        dateCreatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 100, 26)];
//        dateCreatedLabel.textColor = [UIColor blackColor];
//        [imageView setBounds:imageView.frame];
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyCellContents:)];
        [lpgr setMinimumPressDuration:1.0];
        [self addGestureRecognizer:lpgr];
        
        textLabel.numberOfLines = 0;
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        // View testing
//        self.contentView.layer.borderWidth = .5;
//        self.contentView.layer.borderColor = [UIColor orangeColor].CGColor;
        
//        UIPanGestureRecognizer *pg = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(beganPanGesture:)];
//        [self.contentView addGestureRecognizer:pg];
//        [self.contentView setBounds:self.bounds];
//        self.contentView.backgroundColor = [UIColor redColor];
//        textLabel.layer.borderWidth = 1.0f;
//        self.textLabel.font = [UIFont fontWithName:@"GillSans-Light" size:14.0];
        
        imageView.contentMode = UIViewContentModeCenter;
        
        [containerView clipsToBounds];
        
        self.backgroundView = self.contentView;
        [self.contentView addSubview:containerView];
        [self.containerView addSubview:textLabel];
        [self.containerView addSubview:imageView];
    }
    return self;
}

//- (void)beganPanGesture:(UIPanGestureRecognizer *)panGest
//{
//    if (panGest.state == UIGestureRecognizerStateChanged) {
//        if ([panGest translationInView:self.contentView].x < 0)
//            self.contentView.layer.position = CGPointMake([panGest translationInView:self.contentView].x, self.contentView.layer.position.y);
////        self.contentView.layer.position = [panGest translationInView:self.contentView];
//    }
//    NSLog(@"%.2f %.2f", [panGest translationInView:self].x, [panGest translationInView:self].y);
//}

- (void)copyCellContents:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateEnded) {
        NSString *alertMessage = [[NSString alloc] init];
        if (textLabel.hidden == NO) {
            [[UIPasteboard generalPasteboard] setString:textLabel.text];
            alertMessage = @"Copied Text!";
        } else {
            [[UIPasteboard generalPasteboard] setImage:imageView.image];
            alertMessage = @"Copied Image!";
        }
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:alertMessage message:nil delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [av show];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
