//
//  WWDCViewController.m
//  WWDCChecker
//
//  Created by Kishikawa Katsumi on 12/04/11.
//  Copyright (c) 2012 Kishikawa Katsumi. All rights reserved.
//

#import "WWDCViewController.h"

@interface WWDCViewController () {
    UIBarButtonItem *backButton;
    UIBarButtonItem *forwardButton;
    UIBarButtonItem *reloadButton;
	UIBarButtonItem *stopButton;
	UIBarButtonItem *actionButton;
	UIBarButtonItem *flexibleSpace;
	UIBarButtonItem *fixedSpace;
}

@end

@implementation WWDCViewController

@synthesize webView;
@synthesize toolbar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:webView action:@selector(goBack)];
    forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward.png"] style:UIBarButtonItemStylePlain target:webView action:@selector(goForward)];
    reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:webView action:@selector(reload)];
    stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:webView action:@selector(stopLoading)];
    actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(action:)];
    flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    toolbar.items = [NSArray arrayWithObjects:flexibleSpace, backButton, flexibleSpace, forwardButton, flexibleSpace, reloadButton, flexibleSpace, actionButton, flexibleSpace, nil];
    
    backButton.enabled = webView.canGoBack;
    forwardButton.enabled = webView.canGoForward;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://developer.apple.com/wwdc/"]];
    [request setHTTPShouldHandleCookies:NO];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    [webView loadRequest:request];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark -

- (void)action:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel" 
                                         destructiveButtonTitle:nil 
                                              otherButtonTitles:@"Open Web with Safari", nil];
    [sheet showFromToolbar:toolbar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:webView.request.URL];
    }
}

- (void)startLoading {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    toolbar.items = [NSArray arrayWithObjects:flexibleSpace, backButton, flexibleSpace, forwardButton, flexibleSpace, stopButton, flexibleSpace, actionButton, flexibleSpace, fixedSpace, nil];
}

- (void)finishLoading {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    toolbar.items = [NSArray arrayWithObjects:flexibleSpace, backButton, flexibleSpace, forwardButton, flexibleSpace, reloadButton, flexibleSpace, actionButton, flexibleSpace, fixedSpace, nil];
    
    backButton.enabled = webView.canGoBack;
    forwardButton.enabled = webView.canGoForward;
}

- (BOOL)webView:(UIWebView *)web shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)web {
    [self startLoading];
}

- (void)webViewDidFinishLoad:(UIWebView *)web {
    [self finishLoading];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self finishLoading];
}

@end
