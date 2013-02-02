//
//  icheckinAppDelegate.h
//  icheckin
//
//  Created by Thanh Pham on 2/2/13.
//  Copyright (c) 2013 Thanh Pham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "icheckinViewController.h"


@interface icheckinAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)openSession;
- (void) logoutSession;
@property (strong, nonatomic) UINavigationController* navController;
extern NSString *const SCSessionStateChangedNotification;


@end
