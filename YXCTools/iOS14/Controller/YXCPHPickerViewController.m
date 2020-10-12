//
//  YXCPHPickerViewController.m
//  YXCTools
//
//  Created by GGT on 2020/10/12.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPHPickerViewController.h"
#import <PhotosUI/PhotosUI.h>

@interface YXCPHPickerViewController ()<PHPickerViewControllerDelegate>

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation YXCPHPickerViewController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)choosePhoto {
    
    if (@available(iOS 14, *)) {
        PHPickerConfiguration *configuration = [PHPickerConfiguration new];
        configuration.filter = [PHPickerFilter imagesFilter]; // 设置所选的类型,这里设置是图片,默认是 nil,设置成 nil 则代表所有的类型都显示出来(包括 视频/LivePhoto )
        configuration.selectionLimit = 10; // 设置可选择的最大数,默认为 1
        
        PHPickerViewController *picker = [[PHPickerViewController alloc] initWithConfiguration:configuration];
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol

#pragma mark - PHPickerViewControllerDelegate

- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results  API_AVAILABLE(ios(14)){
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (!results || !results.count) return;
    // 遍历获取到的结果
    for (PHPickerResult *result in results) {
        NSItemProvider *itemProvider = result.itemProvider;
        if ([itemProvider canLoadObjectOfClass:UIImage.class]) {
            [itemProvider loadObjectOfClass:UIImage.class
                          completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
                // 取出图片
                if (!error && object && [object isKindOfClass:UIImage.class]) {
                    NSLog(@"%@", object);
                }
            }];
        }
    }
}


#pragma mark - UI

- (void)setupUI {
    
    UIButton *button = [UIButton new];
    button.width = 150;
    button.height = 50;
    button.center = self.view.center;
    button.backgroundColor = UIColor.orangeColor;
    [button setTitle:@"选择照片" forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(choosePhoto)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.width = 200;
    self.timeLabel.height = 40;
    self.timeLabel.center = self.view.center;
    self.timeLabel.top = button.bottom + 40;
    self.timeLabel.font = [UIFont systemFontOfSize:15.0];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    NSString *timeString = [NSDate yxc_stringWithDate:[NSDate date]];
    self.timeLabel.text = timeString;
    [self.view addSubview:self.timeLabel];
    
    // Date转换成时间戳
    NSString *dateString = @"2020-10-12 16:52:58";
    NSDate *date = [NSDate yxc_dateWithDateString:dateString];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    YXCLog(@"%ld", (long)timeInterval);
    YXCLog(@"%ld", (long)[NSDate yxc_timeIntervalWithDate:date]);
    YXCLog(@"%ld", (long)[NSDate yxc_timeIntervalWithDateString:dateString]);
    
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
