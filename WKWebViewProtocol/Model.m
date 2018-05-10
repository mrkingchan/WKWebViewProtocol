//
//  Model.m
//  WKWebViewProtocol
//
//  Created by Macx on 2018/4/26.
//  Copyright © 2018年 Chan. All rights reserved.
//

#import "Model.h"

@implementation Model

-(instancetype)initWithName:(NSString *)name {
    if (self = [super  init]) {
        _name = name;
        
    }
    return self;
}
@end
