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
        configuration.filter = [PHPickerFilter imagesFilter];
        configuration.selectionLimit = 10;
        
        PHPickerViewController *picker = [[PHPickerViewController alloc] initWithConfiguration:configuration];
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        picker.view.backgroundColor = [UIColor orangeColor];
        
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
    
    for (PHPickerResult *result in results) {
        NSItemProvider *itemProvider = result.itemProvider;
        if ([itemProvider canLoadObjectOfClass:UIImage.class]) {
            [itemProvider loadObjectOfClass:UIImage.class
                          completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
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
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *timeString = [NSDate yxc_dateWithTimeIntervalSince1970:[date timeIntervalSince1970] * 1000];
    self.timeLabel.text = timeString;
    [self.view addSubview:self.timeLabel];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
