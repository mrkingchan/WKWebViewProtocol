
//
//  IMessageModel.h
//  WKWebViewProtocol
//
//  Created by Macx on 2018/4/26.
//  Copyright © 2018年 Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IMessageModel <NSObject>

@property(nonatomic,strong)NSString *name;

- (instancetype)initWithName:(NSString*)name;


@end
