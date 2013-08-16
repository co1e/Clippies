//
//  AppDelegate.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "AppDelegate.h"
#import "PasteTableViewController.h"
#import "PasteCoordinatingStore.h"
#import "TACHomeTableViewController.h"
#import "TACCollectionViewController.h"

@implementation AppDelegate

- (void)loadAppearance
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, 0.25);
    shadow.shadowColor = [UIColor colorWithRed:0.955 green:1.000 blue:0.972 alpha:.500];
    shadow.shadowBlurRadius = 10.00f;
    NSDictionary *titleTextAttributes = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor colorWithRed:0.710 green:0.002 blue:0.115 alpha:1.000], [UIFont fontWithName:@"AvenirNext-Medium" size:18.0], shadow, nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, NSShadowAttributeName, nil]];
    
    NSDictionary *bbiTitleTextAttributes = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor darkGrayColor], [UIFont fontWithName:@"AvenirNext-Regular" size:18.0], shadow, nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, NSShadowAttributeName, nil]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:titleTextAttributes];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:bbiTitleTextAttributes forState:UIControlStateNormal];
//    [[[UITableViewCell appearance] textLabel] setFont:[UIFont fontWithName:@"Avenir-Light" size:18.0]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    UIDevice *currentDevice = [UIDevice currentDevice];
//    if (currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
//        
//    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    TACHomeTableViewController *pmtvc = [[TACHomeTableViewController alloc] init];
//    PasteTableViewController *ptvc = [[PasteTableViewController alloc] init];
    
    UICollectionViewFlowLayout *cvfl = [[UICollectionViewFlowLayout alloc] init];
    cvfl.minimumLineSpacing = 5.0f;
    cvfl.minimumInteritemSpacing = 10.0f;
    
    TACCollectionViewController *tacvc = [[TACCollectionViewController alloc] initWithCollectionViewLayout:cvfl];
    UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:tacvc];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.window.tintColor = [UIColor colorWithRed:0.667 green:0.000 blue:0.000 alpha:1.000];
    
    unc.viewControllers = [NSArray arrayWithObjects:pmtvc, tacvc, nil];
//    unc.navigationBar.barTintColor = [UIColor lightGrayColor];
//    unc.navigationBar.translucent = YES;
    
    [self loadAppearance];
    
//    NSDictionary *titleTextAttributes = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor lightGrayColor], [UIFont fontWithName:@"Avenir-Light" size:18.0], nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, nil]];
//    [unc.navigationBar setTitleTextAttributes:titleTextAttributes];
    
//    self.window.tintColor = [UIColor colorWithRed:0.667 green:0.000 blue:0.000 alpha:0.500];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = unc;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    BOOL success = [[PasteCoordinatingStore sharedStore] saveChanges];
    
    if (!success) {
        NSLog(@"Could not save all pastes.");
    } else {
        NSLog(@"Saved all pastes.");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    UIPasteboard *gpb = [UIPasteboard generalPasteboard];
//    NSLog(@"String: %@", gpb.string);
    BOOL success = [[PasteCoordinatingStore sharedStore] saveChanges];
    
    if (!success) {
        if ([[UIApplication sharedApplication] scheduledLocalNotifications] > 0) {
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
        }
        // Replace local notification with AlertView
//        UIAlertView *av
        UILocalNotification *ln = [[UILocalNotification alloc] init];
        if (ln) {
            ln.alertBody = @"App wasn't able to save pastes. Please go into a paste and save.";
        }
        [[UIApplication sharedApplication] presentLocalNotificationNow:ln];
    } else {
        NSLog(@"Saved all pastes! Woohoo!");
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
