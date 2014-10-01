//
//  ViewController.m
//  SafariTNG
//
//  Created by Taylor Wright-Sanson on 10/1/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initlize webview with homepage
    [self loadWebsite:@"taylorwrightsanson.com"];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self loadWebsite:textField.text];

    return YES;
}

- (void)loadWebsite: (NSString *)webAddress {

    if ([webAddress containsString:@"http://"]) {
        NSURL *url = [NSURL URLWithString:webAddress];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:urlRequest];
    }
    else {
        NSString *httpPrefix = @"http://www.";
        NSString *urlString = [httpPrefix stringByAppendingString:webAddress];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:urlRequest];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.delegate = self;
    alertView.title = @"Error!";
    alertView.message = error.localizedDescription;
    [alertView addButtonWithTitle:@"Try again"];
    [alertView addButtonWithTitle:@"Go Home"];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self loadWebsite:@"http://www.taylorwrightsanson.com"];
    }
}

@end
