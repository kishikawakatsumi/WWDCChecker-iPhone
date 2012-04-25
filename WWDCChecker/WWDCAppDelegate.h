//
//  WWDCAppDelegate.h
//  WWDCChecker
//
//  Created by Kishikawa Katsumi on 12/04/11.
//  Copyright (c) 2012 Kishikawa Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class WWDCViewController;

@interface WWDCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) WWDCViewController *viewController;

@end
