//
//  YXCUIPageControlController.m
//  YXCTools
//
//  Created by GGT on 2020/9/21.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCUIPageControlController.h"

@interface YXCUIPageControlController ()



@end

@implementation YXCUIPageControlController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 30)];
    pageControl.backgroundColor = [UIColor orangeColor];
    pageControl.numberOfPages = 6;
    
    if (@available(iOS 14.0, *)) {
        pageControl.backgroundStyle = UIPageControlBackgroundStyleMinimal;
        pageControl.allowsContinuousInteraction = false;
        pageControl.preferredIndicatorImage = [UIImage imageNamed:@"page_currentImage"];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [pageControl setIndicatorImage:[UIImage imageNamed:@"live"] forPage:2];
    } else {
        [pageControl setValue:[UIImage imageNamed:@"page_image"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"page_currentImage"] forKeyPath:@"currentPageImage"];
    }
    [self.view addSubview:pageControl];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
