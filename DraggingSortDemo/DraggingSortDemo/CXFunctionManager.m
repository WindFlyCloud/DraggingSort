//
//  CXFunctionManager.m
//  DraggingSortDemo
//
//  Created by WindXu on 17/2/14.
//  Copyright © 2017年 YJKJ-CaoXu. All rights reserved.
//

#import "CXFunctionManager.h"

@implementation CXFunctionManager

static CXFunctionManager * functionManager = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        functionManager = [[CXFunctionManager alloc]init];
    });
    return functionManager;
}
-(NSMutableArray *)myFunctionArray {
    if (!_myFunctionArray) {
        _myFunctionArray = [@[@"推荐",@"视频",@"军事",@"娱乐",@"问答",@"段子",@"趣图",@"财经",@"热点"] mutableCopy];
    }
    return _myFunctionArray;
}
-(NSMutableArray *)otherFunctionArray {
    if (!_otherFunctionArray) {
        _otherFunctionArray = [@[@"房产",@"社会",@"数码",@"美女",@"文化",@"美文",@"星座",@"旅游",@"汽车"]mutableCopy];
    }
    return _otherFunctionArray;
}
@end
