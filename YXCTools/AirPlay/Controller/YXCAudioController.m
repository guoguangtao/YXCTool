//
//  YXCAudioController.m
//  YXCTools
//
//  Created by lbkj on 2021/10/28.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCAudioController.h"
#import <AVFoundation/AVFoundation.h>

@interface YXCAudioController ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end

@implementation YXCAudioController

/// 刷新UI
- (void)injected {
    
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
    
    __weak typeof(self) wkSelf = self;
    NSURL *url = [NSURL URLWithString:@"http://aod.cos.tx.xmcdn.com/group4/M06/87/D1/wKgDs1RMgE6RreGUAB5l2BFTs8I423.mp3"];
    self.playerItem = [AVPlayerItem playerItemWithURL:url];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
//    [self.player play];
    [self.playerItem seekToTime:CMTimeMake(200, 1) completionHandler:^(BOOL finished) {
        [wkSelf.player play];
    }];
    [self addNotification];
    [self.playerItem yxc_addOberser:self
                         forKeyPath:@"status"
                            options:NSKeyValueObservingOptionNew
                             change:^(NSObject * _Nullable object, NSDictionary<NSKeyValueChangeKey,id> * _Nullable change) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        if (status == AVPlayerItemStatusReadyToPlay) {
            YXCLog(@"总时长:%lf", CMTimeGetSeconds(wkSelf.playerItem.duration));
        }
    }];
    
}

- (void)dealloc {
    
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private

- (void)addNotification {
    // 播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidFinish) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)playDidFinish {
    __weak typeof(self) wkSelf = self;
    [self.playerItem seekToTime:CMTimeMake(0, 1) completionHandler:^(BOOL finished) {
        [wkSelf.player play];
    }];
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - Lazy

- (AVPlayer *)player {
    if (_player) {
        return _player;
    }
    _player = [[AVPlayer alloc] init];
    _player.volume = 1.0f;
    _player.allowsExternalPlayback = NO;
    NSError *error = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&error];
    [audioSession setActive:YES error:&error];
//    __weak typeof(self) wkSelf = self;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0f)
                                          queue:dispatch_get_main_queue()
                                     usingBlock:^(CMTime time) {
//        NSInteger second = (NSInteger)CMTimeGetSeconds(wkSelf.playerItem.currentTime);
//        NSInteger duration = (NSInteger)CMTimeGetSeconds(wkSelf.playerItem.duration);
//        YXCLog(@"second:%ld, duration:%ld", second, duration);
    }];
    return _player;
}

@end
