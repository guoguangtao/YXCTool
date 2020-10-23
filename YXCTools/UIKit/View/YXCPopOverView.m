//
//  YXCPopOverView.m
//  YXCTools
//
//  Created by GGT on 2020/10/23.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPopOverView.h"

@interface YXCPopOverView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIColor *yxc_backgroundColor; /**< 背景颜色 */
@property (nonatomic, assign) CGFloat triangleWidth; /**< 三角形宽度 */
@property (nonatomic, assign) CGFloat triangleHeight; /**< 三角形高度 */
@property (nonatomic, assign) CGPoint startPoint; /**< 三角形起始位置 */
@property (nonatomic, assign) CGPoint middlePoint; /**< 三角形中点位置 */
@property (nonatomic, assign) CGPoint endPoint; /**< 三角形结束位置 */

@end

@implementation YXCPopOverView

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.triangleWidth = 10.0f;
        self.triangleHeight = 10.0f;
        self.yxc_backgroundColor = kColorFromHexCode(0x0E0F10);

        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    // 获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y);
    CGContextAddLineToPoint(context, self.middlePoint.x, self.middlePoint.y);
    CGContextAddLineToPoint(context, self.endPoint.x, self.endPoint.y);
    CGContextClosePath(context);
    [self.yxc_backgroundColor setStroke];
    [self.yxc_backgroundColor setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}

#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public

- (void)showForm:(UIView *)view {
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in windows) {
        if (window.height == IPHONE_HEIGHT && window.width == IPHONE_WIDTH) {
            // 坐标系转换
            CGRect convertFrame = [view convertRect:view.bounds toView:window];
            CGFloat centerX = convertFrame.size.width * 0.5 + convertFrame.origin.x;
            
            // 设置当前 x 和 y 坐标
            CGFloat y = convertFrame.origin.y - self.height - 2;
            // 设置当前中间对齐
            self.centerX = centerX;
            // 判断当前 x 是否小于 20,如果小于 20 ,x 直接设置成 20;
            if (self.x < 20) {
                self.x = 20;
            }
            // 判断当前视图右边是否超过 IPHONE_WIDTH - 20
            if (self.right > IPHONE_WIDTH - 20) {
                self.right = IPHONE_WIDTH - 20;
            }
            // 设置 Y 值
            self.y = y;
            // 判断当前 y 是否小于 10,如果小于 10,在下方显示
            if (self.y < 10) {
                y = CGRectGetMaxY(convertFrame) + 2;
                self.y = y;
                // 计算三角形的三个点
                CGPoint middlePoint  = CGPointMake(centerX, CGRectGetMaxY(convertFrame) + 2);
                CGPoint startPoint = CGPointMake(centerX - self.triangleWidth * 0.5, middlePoint.y + self.triangleHeight);
                CGPoint endPoint = CGPointMake(centerX + self.triangleWidth * 0.5, middlePoint.y + self.triangleHeight);
                self.startPoint = [window convertPoint:startPoint toView:self];
                self.middlePoint = [window convertPoint:middlePoint toView:self];
                self.endPoint = [window convertPoint:endPoint toView:self];
                self.contentView.frame = CGRectMake(0, self.triangleHeight, self.width, self.height - self.triangleHeight);
            } else {
                // 计算三角形的三个点
                CGPoint middlePoint = CGPointMake(centerX, convertFrame.origin.y - 2);
                CGPoint startPoint = CGPointMake(centerX - self.triangleWidth * 0.5, middlePoint.y - self.triangleHeight);
                CGPoint endPoint = CGPointMake(centerX + self.triangleWidth * 0.5, middlePoint.y - self.triangleHeight);
                self.startPoint = [window convertPoint:startPoint toView:self];
                self.middlePoint = [window convertPoint:middlePoint toView:self];
                self.endPoint = [window convertPoint:endPoint toView:self];
                // 设置当前内容展示
                self.contentView.frame = CGRectMake(0, 0, self.width, self.height - self.triangleHeight);
            }
            // 设置背景颜色
            self.backgroundColor = [UIColor clearColor];
            // 创建一个 View,然后在 View 上添加手势,移除当前视图
            UIView *view = [[UIView alloc] initWithFrame:window.bounds];
            view.backgroundColor = [UIColor clearColor];
            [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
            [view addSubview:self];
            [window addSubview:view];
            return;
        }
    }
}


#pragma mark - Private

- (void)dismiss {
    
    [self.superview removeFromSuperview];
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = self.yxc_backgroundColor;
    self.contentView.layer.cornerRadius = 10.0f;
    self.contentView.layer.masksToBounds = YES;
    [self addSubview:self.contentView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
