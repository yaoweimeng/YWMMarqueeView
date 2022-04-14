//
//  YWMViewController.m
//  YWMMarqueeView
//
//  Created by yaoweimeng225@163.com on 04/14/2022.
//  Copyright (c) 2022 yaoweimeng225@163.com. All rights reserved.
//

#import "YWMViewController.h"
#import "YWMMarqueeView.h"

@interface YWMViewController ()

@end

@implementation YWMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    YWMMarqueeView *marqueeView = [[YWMMarqueeView alloc] initWithFrame:CGRectMake(0, 200, 100, 24)];
    [self.view addSubview:marqueeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
