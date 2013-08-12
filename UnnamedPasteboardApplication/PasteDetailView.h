//
//  PasteDetailView.h
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Paste;

@interface PasteDetailView : UIViewController <UIImagePickerControllerDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) Paste * paste;

// Presents detail view with only the necessary views as opposed to loading and hiding, which was a dumb idea.
- (id)initWithImage:(UIImage *)image;
- (id)initWithText:(NSString *)text;

@end
