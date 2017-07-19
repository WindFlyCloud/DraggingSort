//
//  ViewController.m
//  DraggingSortDemo
//
//  Created by WindXu on 17/2/14.
//  Copyright © 2017年 YJKJ-CaoXu. All rights reserved.
//

#import "ViewController.h"
#import "CXFunctionController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.title = @"我的应用";
    UIButton * clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBtn.bounds = CGRectMake(0, 0, 50, 50);
    clickBtn.center = self.view.center;
    [clickBtn setTitle:@"点击" forState:UIControlStateNormal];
    [clickBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [clickBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];
    
}

- (void)buttonClick:(UIButton *)btn{
    CXFunctionController * functionVC = [[CXFunctionController alloc]init];
    [self.navigationController pushViewController:functionVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
