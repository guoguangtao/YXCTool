//
//  YXCPopOverView.m
//  YXCTools
//
//  Created by GGT on 2020/10/23.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPopOverView.h"

@interface YXCPopOverView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIColor *yxc_backgroundColor; /**< 背景颜色 */
@property (nonatomic, assign) CGFloat triangleWidth; /**< 三角形宽度 */
@property (nonatomic, assign) CGFloat triangleHeight; /**< 三角形高度 */
@property (nonatomic, assign) CGPoint startPoint; /**< 三角形起始位置 */
@property (nonatomic, assign) CGPoint middlePoint; /**< 三角形中点位置 */
@property (nonatomic, assign) CGPoint endPoint; /**< 三角形结束位置 */
@property (nonatomic, strong) UITableView *tableView;

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
        self.backgroundColor = UIColor.clearColor;
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismiss];
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
            CGSize contentSize = self.size;
            self.frame = window.bounds;
            self.contentView.size = CGSizeMake(contentSize.width, contentSize.height - self.triangleHeight);
            // 坐标系转换
            CGRect convertFrame = [view convertRect:view.bounds toView:window];
            CGFloat centerX = convertFrame.size.width * 0.5 + convertFrame.origin.x;
            // 设置当前 x 和 y 坐标
            CGFloat y = convertFrame.origin.y - contentSize.height - 2;
            // 设置当前中间对齐
            self.contentView.centerX = centerX;
            CGFloat xGap = 5;
            // 判断当前 x 是否小于 xGap,如果小于 xGap ,x 直接设置成 xGap;
            if (self.contentView.x < xGap) {
                self.contentView.x = xGap;
            }
            // 判断当前视图右边是否超过 IPHONE_WIDTH - 20
            if (self.contentView.right > IPHONE_WIDTH - xGap) {
                self.contentView.right = IPHONE_WIDTH - xGap;
            }
            CGFloat yGap = 10;
            // 设置 Y 值
            self.contentView.y = y;
            // 判断当前 y 是否小于 yGap,如果小于 yGap,在下方显示
            if (self.contentView.y < yGap) {
                y = CGRectGetMaxY(convertFrame) + 2 + self.triangleHeight;
                self.contentView.y = y;
                // 计算三角形的三个点
                self.middlePoint  = CGPointMake(centerX, CGRectGetMaxY(convertFrame) + 2);
                self.startPoint = CGPointMake(centerX - self.triangleWidth * 0.5, self.middlePoint.y + self.triangleHeight);
                self.endPoint = CGPointMake(centerX + self.triangleWidth * 0.5, self.middlePoint.y + self.triangleHeight);
            } else {
                self.middlePoint = CGPointMake(centerX, convertFrame.origin.y - 2);
                self.startPoint = CGPointMake(centerX - self.triangleWidth * 0.5, self.middlePoint.y - self.triangleHeight);
                self.endPoint = CGPointMake(centerX + self.triangleWidth * 0.5, self.middlePoint.y - self.triangleHeight);
            }
            
            [window addSubview:self];
        }
        
        return;
    }
}


#pragma mark - Private

- (void)dismiss {
    
    [self removeFromSuperview];
}

- (void)lstMethod:(UIView *)view {
    
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


#pragma mark - Protocol

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = UIColor.whiteColor;
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXCLog(@"%s", __func__);
}

#pragma mark - UI

- (void)setupUI {
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = self.yxc_backgroundColor;
    self.contentView.layer.cornerRadius = 10.0f;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.clipsToBounds = YES;
    [self addSubview:self.contentView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.rowHeight = 30;
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"Cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


#pragma mark - 懒加载

@end
