//
//  WWDCViewController.h
//  WWDCChecker
//
//  Created by Kishikawa Katsumi on 12/04/11.
//  Copyright (c) 2012 Kishikawa Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWDCViewController : UIViewController<UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

@end
