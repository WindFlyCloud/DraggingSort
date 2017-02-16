//
//  CXFunctionCell.h
//  DraggingSortDemo
//
//  Created by WindXu on 17/2/14.
//  Copyright © 2017年 YJKJ-CaoXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXDragSortDelegate <NSObject>

- (void)CXDargSortCellGestureAction:(UIGestureRecognizer *)gestureRecognizer;

- (void)CXDargSortCellCancelSubscribe:(NSString *)subscribe;

- (void)CXDargSortCellCancelSubscribe:(NSString *)subscribe isMyapp:(BOOL)myApp;

@end

@interface CXFunctionCell : UICollectionViewCell

@property (nonatomic,strong) NSString * subscribe;

/**
 图片
 */
@property (nonatomic,strong) UIImageView * functionImg;
/**
 标签
 */
@property (nonatomic,strong) UILabel     * functionLab;

@property (nonatomic,assign) BOOL          isMyapp;

@property (nonatomic,weak) id<CXDragSortDelegate> delegate;

- (void)showDeleteBtn;

@end
