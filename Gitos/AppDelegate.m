//
//  AppDelegate.m
//  Gitos
//
//  Created by Tri Vuong on 12/9/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DashboardViewController.h"
#import "ReposViewController.h"
#import "NewsfeedViewController.h"
#import "GistsViewController.h"
#import "ProfileViewController.h"
#import "StarredViewController.h"
#import "OthersViewController.h"
#import "KeychainHelper.h"
#import "SSKeychain.h"

@interface UINavigationController (autorotate)

@end

@implementation UINavigationController (autorotate)

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}

-(BOOL) shouldAutorotate {
    return NO;
}

@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    [self validateAuthenticationToken];
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [self sendDeviceTokenToServer:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"failed to register for remote notification");
    NSLog(@"%@", error);
}

- (void)sendDeviceTokenToServer:(NSData *)deviceToken
{
    NSLog(@"%@", [self stringWithDeviceToken:deviceToken]);
}

// http://stackoverflow.com/questions/1959600/how-to-use-objective-c-to-send-device-token-for-push-notifications-and-other-use
- (NSString *)stringWithDeviceToken:(NSData *)deviceToken
{
    const char* data = [deviceToken bytes];

    NSMutableString* token = [NSMutableString string];

    for (int i = 0; i < [deviceToken length]; i++) {
        [token appendFormat:@"%02.2hhX", data[i]];
    }

    return [token copy];
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Gitos" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Gitos.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)validateAuthenticationToken
{
    //NSString *authToken = [KeychainHelper getAuthenticationToken];
    NSString *authToken = [SSKeychain passwordForService:@"access_token" account:@"gitos"];
    
    NSLog(@"authToken when app starts is %@", authToken);
    
    if (authToken != nil && authToken != @"") {
        NewsfeedViewController *newsfeedController  = [[NewsfeedViewController alloc] init];
        ReposViewController *reposController        = [[ReposViewController alloc] init];
        GistsViewController *gistsController        = [[GistsViewController alloc] init];
        ProfileViewController *profileController    = [[ProfileViewController alloc] init];
        StarredViewController *starredController    = [[StarredViewController alloc] init];
        OthersViewController *othersController      = [[OthersViewController alloc] init];
        
        UINavigationController *newsfeedNavController = [[UINavigationController alloc] initWithRootViewController:newsfeedController];
        newsfeedNavController.tabBarItem.title = @"News Feed";
        UIImage *newsIconImage = [UIImage imageNamed:@"275-broadcast.png"];
        
        UINavigationController *reposNavController = [[UINavigationController alloc] initWithRootViewController:reposController];
        reposNavController.tabBarItem.title = @"Repos";
        UIImage *reposIconImage = [UIImage imageNamed:@"33-cabinet.png"];
        
        UINavigationController *gistsNavController = [[UINavigationController alloc] initWithRootViewController:gistsController];
        gistsNavController.tabBarItem.title = @"Gists";
        UIImage *gistsIconImage = [UIImage imageNamed:@"179-notepad.png"];

        UINavigationController *starredNavController = [[UINavigationController alloc] initWithRootViewController:starredController];
        starredNavController.tabBarItem.title = @"Starred";
        UIImage *starredIconImage = [UIImage imageNamed:@"28-star_w.png"];
        
        UINavigationController *profileNavController = [[UINavigationController alloc] initWithRootViewController:profileController];
        profileNavController.tabBarItem.title = @"Profile";
        UIImage *profileIconImage = [UIImage imageNamed:@"253-person.png"];
        
        UINavigationController *othersNavController = [[UINavigationController alloc] initWithRootViewController:othersController];
        othersNavController.tabBarItem.title = @"More";
        UIImage *othersIconImage = [UIImage imageNamed:@"256-box2.png"];

        NSArray *viewControllers = [NSArray arrayWithObjects:
                                    newsfeedNavController,
                                    reposNavController,
                                    starredNavController,
                                    gistsNavController,
                                    othersNavController,
                                    nil];
        UITabBarController *tabController = [[UITabBarController alloc] init];
        [tabController setViewControllers:viewControllers];
        [tabController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg.png"]];
        
        UITabBarItem *item0 = [tabController.tabBar.items objectAtIndex:0];
        UITabBarItem *item1 = [tabController.tabBar.items objectAtIndex:1];
        UITabBarItem *item2 = [tabController.tabBar.items objectAtIndex:2];
        UITabBarItem *item3 = [tabController.tabBar.items objectAtIndex:3];
        UITabBarItem *item4 = [tabController.tabBar.items objectAtIndex:4];
        
        [item0 setFinishedSelectedImage:newsIconImage withFinishedUnselectedImage:newsIconImage];
        [item1 setFinishedSelectedImage:reposIconImage withFinishedUnselectedImage:reposIconImage];
        [item2 setFinishedSelectedImage:starredIconImage withFinishedUnselectedImage:starredIconImage];
        [item3 setFinishedSelectedImage:gistsIconImage withFinishedUnselectedImage:gistsIconImage];
        //[item4 setFinishedSelectedImage:profileIconImage withFinishedUnselectedImage:profileIconImage];
        [item4 setFinishedSelectedImage:othersIconImage withFinishedUnselectedImage:othersIconImage];
        
        [self.window setRootViewController:tabController];
    } else {
        LoginViewController *loginController = [[LoginViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginController];
        [self.window setRootViewController:navController];
    }
    
}
@end
