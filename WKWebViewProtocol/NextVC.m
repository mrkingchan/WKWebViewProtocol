//
//  NextVC.m
//  WKWebViewProtocol
//
//  Created by Macx on 2018/4/26.
//  Copyright © 2018年 Chan. All rights reserved.
//

#import "NextVC.h"

@interface NextVC ()

@end

@implementation NextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_delegate  && [_delegate respondsToSelector:@selector(nextVC:value:)]) {
        [_delegate nextVC:self value:NSStringFromClass([self class])];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
