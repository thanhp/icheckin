//
//  icheckinAppDelegate.m
//  icheckin
//
//  Created by Thanh Pham on 2/2/13.
//  Copyright (c) 2013 Thanh Pham. All rights reserved.
//

#import "icheckinAppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation icheckinAppDelegate

NSString *const SCSessionStateChangedNotification =
@"com.facebook.Scrumptious:SCSessionStateChangedNotification";

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:SCSessionStateChangedNotification
     object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)logoutSession
{
   [FBSession.activeSession closeAndClearTokenInformation];
}

- (void)openSession
{
    NSArray *permissions =
    [NSArray arrayWithObjects:@"user_about_me",  @"user_checkins", @"friends_checkins", @"publish_checkins", nil];

    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler: ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
        
     }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FBProfilePictureView class];
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // Yes, so just open the session (this won't display any UX).
        [self openSession];
    }
    
    

    return TRUE;
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
    // We need to properly handle activation of the application with regards to Facebook Login
    // (e.g., returning from iOS 6.0 Login Dialog or from fast app switching).
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

- (void) applicationDidFinishLaunching:(UIApplication *)application {
   }

@end
