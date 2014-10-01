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
@property (weak, nonatomic) IBOutlet UITextField *webAddressBarTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadHomePage];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self checkAndLoadURLString:textField.text];

    return YES;
}

- (void)checkAndLoadURLString: (NSString *)webAddress {

    if ([webAddress containsString:@"http://"]) {
        [self loadURLString:webAddress];
    }
    else if ([webAddress containsString:@"www."]) {
        NSString *httpPrefix = @"http://";
        NSString *urlString = [httpPrefix stringByAppendingString:webAddress];
        [self loadURLString:urlString];
    }
    else {
        NSString *httpPrefix = @"http://www.";
        NSString *urlString = [httpPrefix stringByAppendingString:webAddress];
        [self loadURLString:urlString];
    }
}

- (void)loadURLString: (NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];

    [self updatePlaceHolderTextInTextField:urlString];
}

- (void)loadHomePage {
    NSString *homePage = @"taylorwrightsanson.com" ;
    [self checkAndLoadURLString:homePage];
    [self updatePlaceHolderTextInTextField:homePage];
}

- (void)updatePlaceHolderTextInTextField: (NSString *)currentURLString {
    self.webAddressBarTextField.text = currentURLString;
    //self.webAddressBarTextField.placeholder = currentURLString;
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
        [self loadHomePage];
    }
}

@end
