//
//  CustomPasteCell.h
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/30/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Paste;

@interface CustomPasteCell : UITableViewCell <UIAlertViewDelegate>
{
    CGPoint textLabelOriginalPos;
    CGPoint imageViewOriginalPos;
}
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView * containerView;
//@property (strong, nonatomic) UILabel *copiedLabel;
//@property (strong, nonatomic) UILabel *dateCreatedLabel;

@end
