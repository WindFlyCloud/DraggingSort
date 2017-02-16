//
//  CXFunctionController.h
//  DraggingSortDemo
//
//  Created by WindXu on 17/2/14.
//  Copyright © 2017年 YJKJ-CaoXu. All rights reserved.
//

#import <UIKit/UIKit.h>

/***  当前屏幕宽度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/***  当前屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
/***  屏宽比例 */
#define SCREEN_WIDTH_RATIO (SCREEN_WIDTH / 375)
#define kLineHeight (1 / [UIScreen mainScreen].scale)
#pragma mark - 字体
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:((size) * SCREEN_WIDTH_RATIO + SCREEN_WIDTH_RATIO * (SCREEN_WIDTH_RATIO < 1 ? 1 : - 1 ))]

//根据RGB值创建UIColor
#define RGBColorMake(R,G,B,_alpha_) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:_alpha_]


@interface CXFunctionController : UIViewController

@end
