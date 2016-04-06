//
//  RootViewController.m
//  饼状图
//
//  Created by 魏永贺 on 16/4/5.
//  Copyright © 2016年 魏永贺. All rights reserved.
//

#import "RootViewController.h"
#import "RootView.h"
@interface RootViewController ()

@property (nonatomic,strong)RootView *rootView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    传颜色值
    NSArray *testArray = @[];
    
    self.rootView = [[RootView alloc]initWithFrame:CGRectMake(70, 30, [UIScreen mainScreen].bounds.size.width-140, 300) withStrokeWidth:90 andColor:[UIColor redColor] andPerArray:testArray  andAnimation:YES];
    
    [self.view addSubview:self.rootView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
