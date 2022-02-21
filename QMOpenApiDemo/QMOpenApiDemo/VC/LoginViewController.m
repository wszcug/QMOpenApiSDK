//
//  LoginViewController.m
//  QMOpenApiDemo
//
//  Created by wsz on 2021/12/31.
//

#import "LoginViewController.h"
#import <WebKit/WebKit.h>
@interface LoginViewController ()<WKNavigationDelegate>
@property (nonatomic, copy)NSString *webUrl;
@end

@implementation LoginViewController

- (instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        self.webUrl = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebView *web =[[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    web.navigationDelegate = self;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *url = navigationAction.request.URL;
    if (url.scheme.length && ![url.scheme hasPrefix:@"http"]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {}];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
