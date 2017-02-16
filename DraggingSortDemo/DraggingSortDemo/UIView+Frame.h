//
//  UIView+Frame.h
//  DraggingSortDemo
//
//  Created by WindXu on 17/2/14.
//  Copyright © 2017年 YJKJ-CaoXu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SKOscillatoryAnimationToBigger,
    SKOscillatoryAnimationToSmaller,
} SKOscillatoryAnimationType;

@interface UIView (Frame)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
@property (nonatomic, readonly) CGFloat screenX;
@property (nonatomic, readonly) CGFloat screenY;

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer
                                     type:(SKOscillatoryAnimationType)type;

@end
