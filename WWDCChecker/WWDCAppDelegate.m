//
//  WWDCAppDelegate.m
//  WWDCChecker
//
//  Created by Kishikawa Katsumi on 12/04/11.
//  Copyright (c) 2012 Kishikawa Katsumi. All rights reserved.
//

#import "WWDCAppDelegate.h"
#import "WWDCViewController.h"

@implementation WWDCAppDelegate

@synthesize window;
@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if !(TARGET_IPHONE_SIMULATOR)
    TESTFLIGHT_TAKEOFF;
#endif
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    
    [Parse setApplicationId:@"SCRdFC3GKlr9WD5ElC9IGpBZewLxDhrl2zSQOKlu" 
                  clientKey:@"5cRNScoCLbMlnPbgwznv40TxNRJKrVQGmXWwbCH5"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.viewController = [[WWDCViewController alloc] initWithNibName:@"WWDCViewController" bundle:nil];
    window.rootViewController = viewController;
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken 
{
    [PFPush storeDeviceToken:newDeviceToken];
    [PFPush subscribeToChannelInBackground:@""];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error 
{
    if ([error code] == 3010) {
        NSLog(@"%@", @"Push notifications don't work in the simulator!");
    }
    
    NSString *message = error.localizedDescription;
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *infoDictionary = [bundle localizedInfoDictionary];
    NSString *appName = [[infoDictionary count] ? infoDictionary : [bundle infoDictionary] objectForKey:@"CFBundleName"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:appName message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo 
{
    [PFPush handlePush:userInfo];
}

@end
