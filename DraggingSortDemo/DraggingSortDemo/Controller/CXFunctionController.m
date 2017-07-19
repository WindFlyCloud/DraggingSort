//
//  CXFunctionController.m
//  DraggingSortDemo
//
//  Created by WindXu on 17/2/14.
//  Copyright © 2017年 YJKJ-CaoXu. All rights reserved.
//

#import "CXFunctionController.h"
#import "CXFunctionManager.h"
#import "CXFunctionCell.h"
#import "UIView+Frame.h"

#define kSpaceBetweenSubscribe  5 * SCREEN_WIDTH_RATIO
#define kVerticalSpaceBetweenSubscribe  1 * SCREEN_WIDTH_RATIO
#define kSubscribeHeight  90 * SCREEN_WIDTH_RATIO
#define kContentLeftAndRightSpace  5 * SCREEN_WIDTH_RATIO
#define kTopViewHeight  64 * SCREEN_WIDTH_RATIO

@interface CXFunctionController ()<UICollectionViewDataSource,CXDragSortDelegate,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView * dragSortView;
@property (nonatomic,strong) UIView * snapshotView; //截屏得到的view
@property (nonatomic,weak)   CXFunctionCell * placeHolderCell;
@property (nonatomic,weak)   CXFunctionCell * originalCell;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,strong) NSIndexPath * nextIndexPath;
@property (nonatomic,strong) UIButton * sortDeleteBtn;

@property (nonatomic,strong) UIButton * rightManagerBtn;
@property (nonatomic,strong) UIButton * leftBtn;
@property (nonatomic,strong) UILabel  * leftLaBel;

@end

@implementation CXFunctionController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"全部应用";
    [self.view addSubview:self.rightManagerBtn];
    [self setLeftBackButtonItem];
    [self.view addSubview:self.dragSortView];
}
-(UIButton *)rightManagerBtn {
    if (!_rightManagerBtn) {
        _rightManagerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightManagerBtn setTitle:@"管理" forState:UIControlStateNormal];
        [_rightManagerBtn setTitle:@"完成" forState:UIControlStateSelected];
        [_rightManagerBtn setBounds:CGRectMake(0, 0, 40, 18)];
        [_rightManagerBtn addTarget:self action:@selector(rightBtnManagerClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:_rightManagerBtn];
        self.navigationItem.rightBarButtonItem = btn;
    }
    return _rightManagerBtn;
}
- (void)setLeftBackButtonItem {
    if (self.navigationController!=nil) {
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Common_ArrowBack_img_n"]];
        _leftLaBel=[[UILabel alloc] init];
        _leftLaBel.text = @"返回";
        _leftLaBel.textColor = [UIColor whiteColor];
        _leftLaBel.font = [UIFont systemFontOfSize:17.0];
        [_leftLaBel sizeToFit];
        
        int space = 6;
        _leftLaBel.left = imageView.left+imageView.width+space;
        imageView.top += space;
        _leftLaBel.top += space;
        
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, _leftLaBel.width+imageView.width+3*space, imageView.frame.size.height+2*space)];
        view.bounds = CGRectMake(view.left+8, view.top-1, view.width, view.height);
        [view addSubview:imageView];
        [view addSubview:_leftLaBel];
        
        _leftBtn=[[UIButton alloc] initWithFrame:view.frame];
        [_leftBtn addTarget:self action:@selector(leftBtnBackClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_leftBtn];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    }
}
- (void)leftBtnBackClick:(UIButton *)leftBtn {
    [CXFunctionManager shareInstance].isEditing = ![CXFunctionManager shareInstance].isEditing;
    _rightManagerBtn.selected = [CXFunctionManager shareInstance].isEditing;
    _leftBtn.selected = [CXFunctionManager shareInstance].isEditing;
    if (_leftBtn.selected) {
        _leftLaBel.text = @"取消";
    }else{
        _leftLaBel.text = @"返回";
    }
    if (!leftBtn.selected) {
        self.dragSortView.scrollEnabled = ![CXFunctionManager shareInstance].isEditing;
        [self.dragSortView reloadData];
    }else{
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }

}
- (void)rightBtnManagerClick:(UIButton *)rightBtn {
    [CXFunctionManager shareInstance].isEditing = ![CXFunctionManager shareInstance].isEditing;
    rightBtn.selected = [CXFunctionManager shareInstance].isEditing;
    _leftBtn.selected = [CXFunctionManager shareInstance].isEditing;
    if (_leftBtn.selected) {
        _leftLaBel.text = @"取消";
    }else{
        _leftLaBel.text = @"返回";
    }
    self.dragSortView.scrollEnabled = ![CXFunctionManager shareInstance].isEditing;
    [self.dragSortView reloadData];
    
}
#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return [CXFunctionManager shareInstance].myFunctionArray.count;
    }
    return [CXFunctionManager shareInstance].otherFunctionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CXFunctionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DargSortCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.functionImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row]];
    if (indexPath.section == 0) {
        cell.subscribe = [CXFunctionManager shareInstance].myFunctionArray[indexPath.row];
        cell.isMyapp = YES;
    }else{
        cell.subscribe = [CXFunctionManager shareInstance].otherFunctionArray[indexPath.row];
        cell.isMyapp = NO;
    }
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView * headerView;
    if (kind == UICollectionElementKindSectionHeader) {
       headerView  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SectionHeader" forIndexPath:indexPath];
        [headerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(5, 0, CGRectGetWidth(self.view.frame), 30);
        if (indexPath.section == 0) {
            titleLabel.text = @"   我的应用";
        }else {
            titleLabel.text = @"   其他应用";
        }
        [headerView addSubview:titleLabel];
    }
    return headerView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
     NSLog(@"myFunctionArray-----%d,%d,%@",indexPath.item,indexPath.section,[CXFunctionManager shareInstance].myFunctionArray[indexPath.row]);
    }else{
       NSLog(@"otherFunctionArray-----%d,%d,%@",indexPath.item,indexPath.section,[CXFunctionManager shareInstance].otherFunctionArray[indexPath.row]);
    }
}

#pragma mark - CXDragSortDelegate

- (void)CXDargSortCellGestureAction:(UIGestureRecognizer *)gestureRecognizer{
    
    //记录上一次手势的位置
    static CGPoint startPoint;
    //触发长按手势的cell
    CXFunctionCell * cell = (CXFunctionCell *)gestureRecognizer.view;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        if (![CXFunctionManager shareInstance].isEditing) {
            return;
        }
        
        NSArray *cells = [self.dragSortView visibleCells];
        for (CXFunctionCell *cell in cells) {
            [cell showDeleteBtn];
        }
        
        //获取cell的截图
//        _snapshotView  = [cell snapshotViewAfterScreenUpdates:YES];
        _snapshotView  = [self customSnapShotFromView:cell];
        _snapshotView.center = cell.center;
        
        [_dragSortView addSubview:_snapshotView];
        _indexPath = [_dragSortView indexPathForCell:cell];
        _originalCell = cell;
        _originalCell.hidden = YES;
        startPoint = [gestureRecognizer locationInView:_dragSortView];
        
        //移动
    }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
        
        CGFloat tranX = [gestureRecognizer locationOfTouch:0 inView:_dragSortView].x - startPoint.x;
        CGFloat tranY = [gestureRecognizer locationOfTouch:0 inView:_dragSortView].y - startPoint.y;
        
        //设置截图视图位置
        _snapshotView.center = CGPointApplyAffineTransform(_snapshotView.center, CGAffineTransformMakeTranslation(tranX, tranY));
        startPoint = [gestureRecognizer locationOfTouch:0 inView:_dragSortView];
        //计算截图视图和哪个cell相交
        for (UICollectionViewCell *cell in [_dragSortView visibleCells]) {
            //跳过隐藏的cell
            if ([_dragSortView indexPathForCell:cell] == _indexPath || [[_dragSortView indexPathForCell:cell] item] == 0) {
                continue;
            }
            //计算中心距
            CGFloat space = sqrtf(pow(_snapshotView.center.x - cell.center.x, 2) + powf(_snapshotView.center.y - cell.center.y, 2));
            
            //如果相交一半且两个视图Y的绝对值小于高度的一半就移动
            if (space <= _snapshotView.bounds.size.width * 0.5 && (fabs(_snapshotView.center.y - cell.center.y) <= _snapshotView.bounds.size.height * 0.5)) {
                _nextIndexPath = [_dragSortView indexPathForCell:cell];
                if (_nextIndexPath.item > _indexPath.item) {
                    for (NSUInteger i = _indexPath.item; i < _nextIndexPath.item ; i ++) {
                        [[CXFunctionManager shareInstance].myFunctionArray exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
                    }
                }else{
                    for (NSUInteger i = _indexPath.item; i > _nextIndexPath.item ; i --) {
                        [[CXFunctionManager shareInstance].myFunctionArray exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
                    }
                }
                //移动
                [_dragSortView moveItemAtIndexPath:_indexPath toIndexPath:_nextIndexPath];
                //设置移动后的起始indexPath
                _indexPath = _nextIndexPath;
                break;
            }
        }
        //停止
    }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        [_snapshotView removeFromSuperview];
        _originalCell.hidden = NO;
    }
}
- (UIView *)customSnapShotFromView:(UIView *)inputView
{
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.center = inputView.center;
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.3;
    
    return snapshot;
    
}
- (void)CXDargSortCellCancelSubscribe:(NSString *)subscribe {
    
//    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"取消订阅%@",subscribe] message:nil preferredStyle:UIAlertControllerStyleAlert];
//    [self presentViewController:alertController animated:YES completion:^{
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [alertController dismissViewControllerAnimated:YES completion:nil];
//        });
//    }];
    
}
- (void)CXDargSortCellCancelSubscribe:(NSString *)subscribe isMyapp:(BOOL)myApp{
    if (myApp) {
        [[CXFunctionManager shareInstance].myFunctionArray removeObject:subscribe];
        [[CXFunctionManager shareInstance].otherFunctionArray addObject:subscribe];
    }else{
        [[CXFunctionManager shareInstance].otherFunctionArray removeObject:subscribe];
        [[CXFunctionManager shareInstance].myFunctionArray addObject:subscribe];
    }
    [self.dragSortView reloadData];
}
- (UICollectionView *)dragSortView {
    
    if (!_dragSortView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (SCREEN_WIDTH - 3 * kSpaceBetweenSubscribe - 2 * kContentLeftAndRightSpace )/4 ;
        layout.itemSize = CGSizeMake(width, kSubscribeHeight + 10 * SCREEN_WIDTH_RATIO);
        layout.minimumLineSpacing = kSpaceBetweenSubscribe;
        layout.minimumInteritemSpacing = kVerticalSpaceBetweenSubscribe;
        layout.sectionInset = UIEdgeInsetsMake(kContentLeftAndRightSpace, kContentLeftAndRightSpace, kContentLeftAndRightSpace, kContentLeftAndRightSpace);
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 30);
        layout.footerReferenceSize = CGSizeMake(0, 0);
        _dragSortView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,kTopViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTopViewHeight) collectionViewLayout:layout];
        //注册cell
        [_dragSortView registerClass:[CXFunctionCell class] forCellWithReuseIdentifier:@"DargSortCell"];
        [_dragSortView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader"];
        _dragSortView.dataSource = self;
        _dragSortView.delegate   = self;
        _dragSortView.backgroundColor = [UIColor whiteColor];
        [CXFunctionManager shareInstance].isEditing = NO;
    }
    return _dragSortView;
}


@end
