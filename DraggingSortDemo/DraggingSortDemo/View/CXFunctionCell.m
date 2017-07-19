//
//  CXFunctionCell.m
//  DraggingSortDemo
//
//  Created by WindXu on 17/2/14.
//  Copyright © 2017年 YJKJ-CaoXu. All rights reserved.
//

#import "CXFunctionCell.h"
#import "CXFunctionManager.h"
#import "UIView+Frame.h"

#import "CXFunctionController.h"

#define kDeleteBtnWH 20 * SCREEN_WIDTH_RATIO

@interface CXFunctionCell()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)  UILabel *label;
@property (nonatomic,assign) BOOL  isEditing;
@property (nonatomic,strong) UIButton * deleteBtn;

@end
@implementation CXFunctionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
//    UIPanGestureRecognizer * pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
//    pan.delegate = self;
//    [self addGestureRecognizer:pan];
    self.backgroundColor = [UIColor yellowColor];
    _functionImg = [[UIImageView alloc] initWithFrame:
                                  CGRectMake(0, 0, 42, 42)];
    _functionImg.center  = self.contentView.center;
    [self.contentView addSubview:_functionImg];
    
    _functionLab = [[UILabel alloc] init];
    _functionLab.textColor = [UIColor blackColor];
    _functionLab.textAlignment = NSTextAlignmentCenter;
    _functionLab.font = [UIFont systemFontOfSize:15];
    _functionLab.left = 0;
    _functionLab.top = CGRectGetMaxY(_functionImg.frame)+10;
    _functionLab.width = self.contentView.width;
    _functionLab.height = 20;
    [self.contentView addSubview:_functionLab];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_deleteBtn setImage:[UIImage imageNamed:@"drag_delete"] forState:UIControlStateNormal];
    _deleteBtn.width = kDeleteBtnWH;
    _deleteBtn.height = kDeleteBtnWH;
    _deleteBtn.right = 0;
    _deleteBtn.left = self.contentView.frame.size.width - kDeleteBtnWH;
    [_deleteBtn addTarget:self action:@selector(cancelSubscribe) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
}

- (void)cancelSubscribe {
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(CXDargSortCellCancelSubscribe:)]) {
//        [self.delegate CXDargSortCellCancelSubscribe:self.subscribe];
//    }
    if (self.delegate &&[self.delegate respondsToSelector:@selector(CXDargSortCellCancelSubscribe:isMyapp:)]) {
        [self.delegate CXDargSortCellCancelSubscribe:self.subscribe isMyapp:_isMyapp];
    }
}
-(void)setIsMyapp:(BOOL)isMyapp {
    
    _isMyapp = isMyapp;
    if (_isMyapp) {
        UIPanGestureRecognizer * pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
        [_deleteBtn setImage:[UIImage imageNamed:@"btn_more_delete"] forState:UIControlStateNormal];
    }else{
        [_deleteBtn setImage:[UIImage imageNamed:@"btn_more_add"] forState:UIControlStateNormal];
    }

}
- (void)showDeleteBtn {
    
    _deleteBtn.hidden = NO;
}

- (void)editStateChange:(NSNotification *)noti {
    
    self.isEditing = YES;
}

- (void)setSubscribe:(NSString *)subscribe {
    
    _subscribe = subscribe;
    _deleteBtn.hidden = ![CXFunctionManager shareInstance].isEditing;
    _functionLab.text = subscribe;
//    _functionLab.width = self.width - kDeleteBtnWH;
//    _functionLab.height = self.height - kDeleteBtnWH;
//    _functionLab.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [CXFunctionManager shareInstance].isEditing && _isMyapp) {
        return YES;
    }
    return NO;
}


- (void)gestureAction:(UIGestureRecognizer *)gestureRecognizer{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CXDargSortCellGestureAction:)]) {
        [self.delegate CXDargSortCellGestureAction:gestureRecognizer];
    }
}

@end
