//
//  YXCPHPickerViewController.m
//  YXCTools
//
//  Created by GGT on 2020/10/12.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPHPickerViewController.h"
#import <PhotosUI/PhotosUI.h>
#import "YXCPopOverView.h"

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

- (void)choosePhoto:(UIButton *)button {
    
    YXCPopOverView *overView = [[YXCPopOverView alloc] init];
    overView.width = 80;
    overView.height = 100;
    [overView showForm:button];
    
    return;
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
               action:@selector(choosePhoto:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [[UIButton alloc] init];
    button1.width = 50;
    button1.height = 50;
    button1.x = 12;
    button1.y = 100;
    button1.backgroundColor = [UIColor orangeColor];
    [button1 addTarget:self action:@selector(choosePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] init];
    button2.width = 50;
    button2.height = 50;
    button2.right = IPHONE_WIDTH - 12;
    button2.y = 100;
    button2.backgroundColor = [UIColor orangeColor];
    [button2 addTarget:self action:@selector(choosePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] init];
    button3.width = 50;
    button3.height = 50;
    button3.right = IPHONE_WIDTH - 100;
    button3.y = 100;
    button3.backgroundColor = [UIColor orangeColor];
    [button3 addTarget:self action:@selector(choosePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc] init];
    button4.width = 50;
    button4.height = 50;
    button4.right = IPHONE_WIDTH - 2;
    button4.y = 200;
    button4.backgroundColor = [UIColor orangeColor];
    [button4 addTarget:self action:@selector(choosePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
