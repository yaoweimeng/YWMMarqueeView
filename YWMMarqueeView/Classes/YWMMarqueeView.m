//
//  YWMMarqueeView.m
//  轮询View
//
//  Created by yaoweimeng on 2022/4/14.
//  Copyright © 2022 YWM. All rights reserved.
//

#import "YWMMarqueeView.h"

@interface YWMMarqueeView ()
/** view */
@property (nonatomic, strong) UIView *rollView;
/** 当前Label */
@property (nonatomic, strong) UILabel *currentLab;
/** 下一个label */
@property (nonatomic, strong) UILabel *nextLab;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;
/** 长 */
@property (nonatomic, assign) CGFloat strWidth;
/** 动画时间 */
@property (nonatomic, assign) CGFloat duration;
@end

@implementation YWMMarqueeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark -- setupViews
- (void)setupViews {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 24)];
    backView.backgroundColor = [UIColor grayColor];
//    backView.clipsToBounds = YES;
    backView.userInteractionEnabled = YES;
    [self addSubview:backView];
    [backView addSubview:self.currentLab];
    [backView addSubview:self.nextLab];
    [self setTitleStr:@"文字展示 文字展示 文字展示 文字展示 文字展示 文字展示 文字展示 文字展示 文字展示 文字展示"];
}

- (void)setTitleStr:(NSString *)titleStr {
    
    CGSize textSize = [titleStr boundingRectWithSize:CGSizeMake(1000000, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSKernAttributeName:@0.0f,NSFontAttributeName:self.currentLab.font} context:nil].size;
    if (textSize.width > 80) {
        self.strWidth = textSize.width;
        self.currentLab.text = titleStr;
        self.nextLab.text = titleStr;
        self.currentLab.frame = CGRectMake(0, 0, textSize.width, 24);
        self.nextLab.frame = CGRectMake(textSize.width + 40, 0, textSize.width, 24);
        self.duration = (textSize.width) / 20.0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(rollLab) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        self.timer.fireDate = [NSDate distantPast];
        
    } else {
        self.currentLab.text = titleStr;
        self.currentLab.frame = CGRectMake(0, 0, textSize.width, 24);
    }
    
}

- (void)rollLab {
    
    
    self.timer.fireDate = [NSDate distantFuture];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.duration delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.currentLab.frame = CGRectMake(- weakSelf.strWidth - 40, 0, weakSelf.strWidth, 24);
        weakSelf.nextLab.frame = CGRectMake(0, 0, weakSelf.strWidth, 24);
    } completion:^(BOOL finished) {
        weakSelf.currentLab.frame = CGRectMake(0, 0, weakSelf.strWidth, 24);
        weakSelf.nextLab.frame = CGRectMake(weakSelf.strWidth + 40, 0, weakSelf.strWidth, 24);
        weakSelf.timer.fireDate = [NSDate distantPast];
    }];

}

- (UILabel *)currentLab {
    if (_currentLab == nil) {
        _currentLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 24)];
        _currentLab.font = [UIFont systemFontOfSize:18];
        _currentLab.textAlignment = NSTextAlignmentLeft;
        _currentLab.textColor = [UIColor blackColor];
    }
    return _currentLab;
}

- (UILabel *)nextLab {
    if (_nextLab == nil) {
        _nextLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 24)];
        _nextLab.font = [UIFont systemFontOfSize:18];
        _nextLab.textAlignment = NSTextAlignmentLeft;
        _nextLab.textColor = [UIColor blackColor];
    }
    return _nextLab;
}

@end

