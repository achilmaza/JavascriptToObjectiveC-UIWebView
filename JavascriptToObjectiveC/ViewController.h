//
//  ViewController.h
//  JavascriptToObjectiveC
//
//  Created by Angie Chilmaza on 9/16/15.
//  Copyright (c) 2015 Angie Chilmaza. All rights reserved.
//

#import <JavaScriptCore/JSExport.h>
#import <JavaScriptCore/JSContext.h>
#import <UIKit/UIKit.h>

//http://nshipster.com/javascriptcore/
@protocol ViewControllerJSExport <JSExport>

-(void)buttonClickNotification;

@end

@interface ViewController : UIViewController <UIWebViewDelegate, ViewControllerJSExport>

@property (nonatomic, strong) IBOutlet UIWebView * wView;

@end

