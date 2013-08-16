//
//  TACCollectionViewController.m
//  Clippings
//
//  Created by Thomas Cole on 8/14/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "TACCollectionViewController.h"
#import "CustomCVCell.h"
#import "PasteCoordinatingStore.h"
#import "Paste.h"

@interface TACCollectionViewController()
{
    BOOL transitioned;
    NSString * currentFilter;
}

@end

@implementation TACCollectionViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
//        CGRect screenBounds = [[UIScreen mainScreen] bounds];
//        [self.collectionView setBounds:CGRectMake(screenBounds.origin.x, screenBounds.origin.y + 25, screenBounds.size.width - 10, screenBounds.size.height - 25)];
        
//        UICollectionViewFlowLayout *cvfl = [[UICollectionViewFlowLayout alloc] init];
//        cvfl.minimumLineSpacing = 5.0f;
//        cvfl.minimumInteritemSpacing = 5.0f;
//        cvfl.itemSize = CGSizeMake(100, 100);
//        self.collectionView.collectionViewLayout = cvfl;
//        layout = cvfl;
        [[[self navigationItem] leftBarButtonItem] setTitle:@""];
        [[NSNotificationCenter defaultCenter] addObserver:self.collectionView selector:@selector(reloadData) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
//    self.navigationItem.title = @"Pastes";
    NSArray * segCtrlItems = [NSArray arrayWithObjects:@"All", @"Text", @"Images", nil];
    UISegmentedControl * segCtrl = [[UISegmentedControl alloc] initWithItems:segCtrlItems];
    
    self.navigationItem.titleView = segCtrl;
    [segCtrl addTarget:self action:@selector(segCtrlChanged:) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem * addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    self.navigationItem.rightBarButtonItem = addBtn;
    transitioned = NO;
    
    UINib *nib = [UINib nibWithNibName:@"CustomCVCell" bundle:nil];
    [[self collectionView] registerNib:nib forCellWithReuseIdentifier:@"CustomCVCell"];
}

- (void)segCtrlChanged:(id)sender
{
    NSLog(@"Segmented control changed.");
    
    if ([sender selectedSegmentIndex] == 0) {
        transitioned = NO;
        currentFilter = @"text";
        UICollectionViewFlowLayout *cvfl = [[UICollectionViewFlowLayout alloc] init];
        cvfl.minimumLineSpacing = 5.0f;
        cvfl.minimumInteritemSpacing = 10.0f;
        [self.collectionView reloadData];
        [self.collectionView setCollectionViewLayout:cvfl animated:YES];
    }
    else if ([sender selectedSegmentIndex] == 1) {
        transitioned = YES;
        currentFilter = @"image";
        UICollectionViewFlowLayout *cvfl = [[UICollectionViewFlowLayout alloc] init];
        cvfl.minimumLineSpacing = 5.0f;
        cvfl.minimumInteritemSpacing = 50.0f;
        //        UICollectionViewTransitionLayout * transition = [[UICollectionViewTransitionLayout alloc] initWithCurrentLayout:self.collectionViewLayout nextLayout:cvfl];
        //        transition.transitionProgress = 50;
        [self.collectionView setCollectionViewLayout:cvfl animated:YES];
        NSIndexPath *ip = [[self collectionView] indexPathForItemAtPoint:self.collectionView.bounds.origin];
        [self.collectionView reloadData];
        [self.collectionView scrollToItemAtIndexPath:ip atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        //        UICollectionViewTransitionLayout * transition = [[UICollectionViewTransitionLayout alloc] initWithCurrentLayout:nil nextLayout:nil];
    }
    else if  ([sender selectedSegmentIndex] == 2) {
        transitioned = NO;
        currentFilter = @"";
        UICollectionViewFlowLayout *cvfl = [[UICollectionViewFlowLayout alloc] init];
        cvfl.minimumLineSpacing = 5.0f;
        cvfl.minimumInteritemSpacing = 10.0f;
        [self.collectionView reloadData];
        [self.collectionView setCollectionViewLayout:cvfl animated:YES];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Paste *p = [[[PasteCoordinatingStore sharedStore] allPastes] objectAtIndex:indexPath.row];;
    
    if ([currentFilter isEqualToString:@""]) {
        p = [[[PasteCoordinatingStore sharedStore] allPastes] objectAtIndex:indexPath.row];
    }
    else if ([currentFilter isEqualToString:@"text"]) {
        p = [[[PasteCoordinatingStore sharedStore] textPastes] objectAtIndex:indexPath.row];
    }
    else if ([currentFilter isEqualToString:@"images"]) {
        p = [[[PasteCoordinatingStore sharedStore] imagePastes] objectAtIndex:indexPath.row];
    }
    
    CustomCVCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCVCell" forIndexPath:indexPath];
    
//    cell.tl.text = @"";
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [UIColor colorWithRed:0.667 green:0.000 blue:0.000 alpha:1.000].CGColor;
    cell.backgroundView.layer.shadowRadius = 0.5f;
    cell.backgroundView.layer.shadowColor = [UIColor grayColor].CGColor;
    cell.backgroundView.layer.shadowOffset = CGSizeMake(-1.0, 0);
    cell.backgroundView.layer.shadowOpacity = 1.0f;
    
    if (![[p.folder valueForKey:@"name"] isEqualToString:@""])
    {
        if ([p.type isEqualToString:@"image"]) {
            cell.tl.text = @"";
            cell.iv.image = [UIImage imageWithData:p.data];
        }
        else if ([p.type isEqualToString:@"text"]) {
//            cell.tl.text = [[NSString alloc] initWithData:p.data encoding:NSUTF8StringEncoding];
            NSError *error;
            
            cell.tl.numberOfLines = 0;
            
            cell.tl.attributedText = [[NSAttributedString alloc] initWithData:p.data options:nil documentAttributes:nil error:&error];
            
            cell.iv.image = nil;
        }
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
//    UIViewController *vc = [[UIViewController alloc] init];
//    [vc setView:view];
    
//    self.transitioningDelegate = self;
    
//    [self animationControllerForPresentedController:vc presentingController:self sourceController:self];
    
//    id <UIViewControllerContextTransitioning> context;
    
    
//    view.backgroundColor = [UIColor blueColor];
//    [self presentViewController:vc animated:YES completion:nil];
    UIActionSheet * actSheet = [[UIActionSheet alloc] initWithTitle:@"Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Edit/View", @"Share", @"Open In...", nil];
    [actSheet showInView:self.view];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = CGSizeZero;
    if (transitioned == NO) {
        itemSize = CGSizeMake(150, 150);
    }
    else if (transitioned == YES) {
        itemSize = CGSizeMake(300, 400);
    }
    return itemSize;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if ([currentFilter isEqualToString:@"text"]) {
        count = [[[PasteCoordinatingStore sharedStore] textPastes] count];
    }
    else if ([currentFilter isEqualToString:@"image"]) {
        count = [[[PasteCoordinatingStore sharedStore] imagePastes] count];
    }
    else {
        count = [[[PasteCoordinatingStore sharedStore] allPastes] count];
    }
    return count;
}

@end
