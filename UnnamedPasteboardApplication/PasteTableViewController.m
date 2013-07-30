//
//  PasteTableViewController.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "PasteTableViewController.h"
#import "PasteDetailView.h"
#import "PasteStringStore.h"
#import "PasteImageStore.h"
#import "Pastes.h"

@implementation PasteTableViewController

- (id)init {
    self = [super init];
    if (self) {
//        UIPasteboard *gpb = [UIPasteboard generalPasteboard];
//        NSLog(@"Item currently on pasteboard: %@", gpb.string);
//        for (int i = 0; i <= 100; ++i) {
//            Pastes *p = [[PasteStringStore sharedStore] createPaste];
//            [p setStringData:gpb.string];
//            [p setImageKey:nil];
//            [p setPasteID:0];
//        }
        self.navigationItem.title = @"Pasties";
        
        UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addOwnPaste:)];
        
        [self.navigationItem setRightBarButtonItem:addBtn];
    }
    return [self initWithStyle:UITableViewStyleGrouped];
}

//- (void)loadView
//{
//    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addOwnPaste:)];
//    
//    [self.navigationItem setRightBarButtonItem:addBtn];
//}

#pragma mark - Table View Stuff

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[PasteStringStore sharedStore] allPastes] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Pastes *p = [[[PasteStringStore sharedStore] allPastes] objectAtIndex:[indexPath row]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [p stringData]];
    
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.imageView.image = [UIImage imageNamed:@"srslyfuckbirds.jpg"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PasteDetailView *pdv = [[PasteDetailView alloc] init];
    [self.navigationController pushViewController:pdv animated:YES];
}

#pragma mark - Own methods

- (void)addOwnPaste:(id)sender
{
    ipc = [[UIImagePickerController alloc] init];
    [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [ipc setDelegate:self];
    
    [self presentViewController:ipc animated:YES completion:nil];
    // Method stub to satisfy addBtn
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    CFUUIDRef newID = CFUUIDCreate(CFAllocatorGetDefault());
//
    NSString *idString = [NSString stringWithFormat:@"%@", newID];
    
    NSLog(@"%@", idString);
    
//    [[PasteImageStore sharedStore] setImage:[info valueForKey:UIImagePickerControllerOriginalImage] forKey:idString];
//    picker = ipc;
    [[PasteImageStore sharedStore] setImage:[info valueForKey:UIImagePickerControllerOriginalImage] forKey:idString];
    NSLog(@"Do we have an image? %@", [[PasteImageStore sharedStore] imageForKey:idString]);
//    NSLog(@"%@", [info valueForKey:UIImagePickerControllerOriginalImage]);
    [[PasteStringStore sharedStore] addImageData:idString];

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
