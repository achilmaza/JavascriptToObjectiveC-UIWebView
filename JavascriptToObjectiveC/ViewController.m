//
//  ViewController.m
//  JavascriptToObjectiveC
//
//  Created by Angie Chilmaza on 9/16/15.
//  Copyright (c) 2015 Angie Chilmaza. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) JSContext * jsContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * indexFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    [self.wView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:indexFile ]]];
    self.wView.delegate = self;
    
}

#pragma UIWebViewDelegate

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"webView error = %@ \n", error.description);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    //    [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
    //                                                     "script.type = 'text/javascript';"
    //                                                     "script.text = \"function myFunction() { "
    //                                                         "var field = document.getElementById('pressMe');"
    //                                                         "field.value='Calling function - OK';"
    //                                                          "console.log(\" Here \");"
    //                                                     "}\";"
    //                                                     "document.getElementsByTagName('head')[0].appendChild(script);"];
    //
    //
    //    NSString *yourHTMLSourceCodeString= [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];

    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [self.jsContext setExceptionHandler:^(JSContext *context, JSValue *value) {
        NSLog(@"WEB JS: %@", value);
    }];
    
    // export ViewController class
    self.jsContext[@"viewController"] = self;
    
    [self.jsContext evaluateScript:@"var buttonClickNotification = function () { "
                                    "   viewController.buttonClickNotification(); "
                                    "}; "];
    
}

-(void)buttonClickNotification{
    
    NSLog(@"Hello! Button in web view has been clicked! \n");
    
}

- (IBAction)alertNotification:(id)sender {

    [self.jsContext evaluateScript:@"alert(\"Hello! Alert button pressed \"); "];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
