//
//  UIWebViewController.m
//  JSInvokeNativeProject
//
//  Created by Jacue on 2017/7/20.
//  Copyright © 2017年 Jacue. All rights reserved.
//

#import "UIWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSNativeProtocol.h"

@interface UIWebViewController () <UIWebViewDelegate,JSNativeProtocol>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
//@property (nonatomic,strong) JSContext *jsContext;

@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"test"
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
}

#pragma mark - JSNativeProtocol

- (NSString *)token {
    return @"hajfhakfhaoiwraowiru";
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"webkit"] =  @{@"messageHandlers":@{@"getToken1":@{@"postMessage":^(id data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *jsStr = [(NSString *)data stringByReplacingOccurrencesOfString:@"deviceToken" withString:[self token]];
            
            [self.webView stringByEvaluatingJavaScriptFromString:jsStr];
        });
    }}}};
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
