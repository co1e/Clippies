//
//  PasteTableViewController.h
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasteTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>
{
    UIImagePickerController *ipc;
    UIActionSheet *actSheet;
    UIAlertView *av;
    UIActivityViewController *avc;
}
@end
