//
//  NextVC.h
//  WKWebViewProtocol
//
//  Created by Macx on 2018/4/26.
//  Copyright © 2018年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NextVC;
@protocol NextVCDelegate <NSObject>

- (void)nextVC:(NextVC *)VC value:(id)value;

@end

@interface NextVC : UIViewController

@property(nonatomic,weak)id <NextVCDelegate >delegate;


@end
