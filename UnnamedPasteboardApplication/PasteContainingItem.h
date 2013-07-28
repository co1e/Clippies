//
//  PasteContainingItem.h
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasteContainingItem : NSObject

@property (weak, nonatomic) UIImage *img;
@property (weak, nonatomic) NSString *str;

- (void)setImage:(UIImage *)image withString:(NSString *)string;

@end
