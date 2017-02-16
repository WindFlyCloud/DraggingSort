//
//  CXFunctionManager.h
//  DraggingSortDemo
//
//  Created by WindXu on 17/2/14.
//  Copyright © 2017年 YJKJ-CaoXu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXFunctionManager : NSObject

@property (nonatomic,assign) BOOL isEditing;
@property (nonatomic,strong) NSMutableArray * myFunctionArray;
@property (nonatomic,strong) NSMutableArray * otherFunctionArray;
+ (instancetype)shareInstance;

@end
