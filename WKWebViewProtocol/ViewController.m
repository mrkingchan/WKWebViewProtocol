//
//  ViewController.m
//  WKWebViewProtocol
//
//  Created by Macx on 2018/4/25.
//  Copyright © 2018年 Chan. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "Model.h"
#import "NextVC.h"

@interface ViewController () <WKUIDelegate,WKNavigationDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NextVCDelegate> {
    WKWebView *_webView;
    UIAlertView *_alertView;
    UIImagePickerController*_pickerController;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*WKWebViewConfiguration *configure = [WKWebViewConfiguration new];
    configure.userContentController = [WKUserContentController new];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) configuration:configure];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.qianft.com:8099"]]];
     */
    

    //taget-Action
    [[self.touch rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"x = %@",x);
        _alertView = [[UIAlertView alloc] initWithTitle:@"xxx" message:@"xxx" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
        [_alertView show];
        /*
         //对delegate的支持
         [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tupe) {
         NSLog(@"first = %@",tupe.first);
         NSLog(@"second = %@",tupe.second);
         }];
         */
        @weakify(self);
        [[_alertView rac_buttonClickedSignal] subscribeNext:^(id x) {
            @strongify(self);
            //rac里面是使用weakify和stringify来避免循环引用
            NSLog(@"x = %@",x);
            NSInteger index =  [x integerValue];
            NSLog(@"你点击的是第%zd个按钮",index);
            if (index == 1) {
                NextVC *next = [NextVC new];
                next.delegate = self;
                [self.navigationController pushViewController:next animated:YES];
                ///rac对代理支持，但是这里值得注意的是，rac的代理目前只能支持返回值是void的代理，带有返回值的代理是不支持的
                [[self rac_signalForSelector:@selector(nextVC:value:) fromProtocol:@protocol(NextVCDelegate)] subscribeNext:^(RACTuple  * tupe) {
                    NSLog(@"value = %@",tupe);
                }];
            }
        }];
        //dismiss
        [[_alertView rac_willDismissSignal] subscribeNext:^(id x) {
            NSLog(@"alertView will dismiss \n x = %@",x);
        }];
    }];
    //通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] subscribeNext:^(NSNotification *noti) {
        NSLog(@"notification = %@",noti.name);
    }];
    
    //KVO
    [RACObserve(self.touch, frame) subscribeNext:^(id x) {
//        NSLog(@"frame = %@",[x CGRectValue]);
    }];
    
    self.view.userInteractionEnabled = YES;
    //对tap的监听
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        NSLog(@"tapview = %@",((UITapGestureRecognizer *)x).view);
    }];
    [self.view addGestureRecognizer:tap];
    
    //信号量
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //发送next信号
        [subscriber sendNext:@"Chan"];
        //发送完成
        [subscriber sendCompleted];
        //释放操作
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    
    //订阅
    [signal subscribeNext:^(id x) {
        NSLog(@"x = %@",x);
    }];
    //订阅错误
    [signal doError:^(NSError *error) {
        NSLog(@"subcribe error = %@",error.localizedDescription);
    }];
    //订阅完成
    [signal doCompleted:^{
        
    }];
    _pickerController = [UIImagePickerController new];
    _pickerController.delegate = self;
    _pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _pickerController.allowsEditing = NO;
    
    
    
    [[self rac_signalForSelector:@selector(touchesBegan:withEvent:)] subscribeNext:^(id x) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.touch.frame = CGRectMake(100, 100, 120, 50);
    [self presentViewController:_pickerController animated:YES completion:nil];
    [[self rac_signalForSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:) fromProtocol:@protocol(UIImagePickerControllerDelegate)] subscribeNext:^(RACTuple *tupe) {
        // tupe里面存着delegate里面的参数
        NSLog(@"first = %@\n second = %@",tupe.first,tupe.second);
    }];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
