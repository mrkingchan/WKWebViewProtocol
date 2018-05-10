//
//  AppDelegate.m
//  WKWebViewProtocol
//
//  Created by Macx on 2018/4/25.
//  Copyright © 2018年 Chan. All rights reserved.
//

#import "AppDelegate.h"
#import <WebKit/WebKit.h>
#import "Protocol.h"
#import "NSURLProtocol+WebKitSupport.h"
#import "ViewController.h"
@interface AppDelegate () {
    NSURLSessionDataTask *_task;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
//    Class cls = NSClassFromString(@"WKBrowsingContextController");
    Class cls = [[[WKWebView new] valueForKey:@"browsingContextController"] class];
    SEL sel = NSSelectorFromString(@"registerSchemeForCustomProtocol:");
    if ([(id)cls respondsToSelector:sel]) {
        // 把 http 和 https 请求交给 NSURLProtocol 处理
        [(id)cls performSelector:sel withObject:@"http"];
        [(id)cls performSelector:sel withObject:@"https"];
    }
    [NSURLProtocol registerClass:[Protocol class]];*/
    [NSURLProtocol wk_registerScheme:@"http"];
    [NSURLProtocol wk_registerScheme:@"https"];
    
  _task =  [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://m.qianft.com:8099/app/getfilterurllist"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
    }] ;
    [_task resume];
   NSLog(@"task HeaderFields = %@", _task.originalRequest.allHTTPHeaderFields);
//    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    _window.backgroundColor = [UIColor whiteColor];
//    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
//    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
