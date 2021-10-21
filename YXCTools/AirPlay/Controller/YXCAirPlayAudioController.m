//
//  YXCAirPlayAudioController.m
//  YXCTools
//
//  Created by lbkj on 2021/10/20.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCAirPlayAudioController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "YXCAudioModel.h"
#import "UIImageView+WebCache.h"

@interface YXCAirPlayAudioController ()

@property (nonatomic, strong) NSArray<YXCAudioModel *> *musics; /**< 音乐资源数组 */
@property (nonatomic, strong) UIImageView *imageView; /**< 音乐专辑图片 */
@property (nonatomic, strong) UIButton *playButton; /**< 播放按钮 */
@property (nonatomic, strong) AVPlayer *player; /**< 播放器 */
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end

@implementation YXCAirPlayAudioController

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    [self setupUI];
    [self setupConstraints];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColorFromHexCode(0xEEEEEE);
    
    [self setupUI];
    [self setupConstraints];
    
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    __weak typeof(self) wkSelf = self;
    [commandCenter.pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        // 暂停
        NSLog(@"暂停");
        [wkSelf pause];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [commandCenter.playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        // 播放
        NSLog(@"播放");
        [wkSelf resumePlay];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [commandCenter.previousTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        // 上一曲
        NSLog(@"上一曲");
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [commandCenter.nextTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
       // 下一曲
        NSLog(@"下一曲");
        return MPRemoteCommandHandlerStatusSuccess;
    }];
}

- (void)dealloc {
    
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)playButtonClicked:(UIButton *)button {
    button.selected = !button.isSelected;
    if (button.isSelected) {
        YXCAudioModel *model = self.musics.firstObject;
        NSURL *url = model.musicUrl;
        self.playerItem = [AVPlayerItem playerItemWithURL:url];
        [self.imageView sd_setImageWithURL:model.musicImage completed:nil];
        __weak typeof(self) wkSelf = self;
        [self.playerItem yxc_addOberser:self
                             forKeyPath:@"status"
                                options:NSKeyValueObservingOptionNew
                                 change:^(NSObject * _Nullable object, NSDictionary<NSKeyValueChangeKey,id> * _Nullable change) {
            NSLog(@"%lf", CMTimeGetSeconds(wkSelf.playerItem.duration));
        }];
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
        [self.player play];
    } else {
        [self.player pause];
    }
}


#pragma mark - Public


#pragma mark - Private

- (void)play {
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

- (void)resumePlay {
    [self.playerItem seekToTime:self.playerItem.currentTime completionHandler:nil];
    [self.player play];
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    self.imageView = [UIImageView new];
    self.imageView.backgroundColor = UIColor.orangeColor;
    self.imageView.layer.cornerRadius = 100;
    self.imageView.layer.masksToBounds = YES;
    [self.view addSubview:self.imageView];
    
    self.playButton = [UIButton new];
    self.playButton.backgroundColor = UIColor.orangeColor;
    self.playButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.playButton addTarget:self action:@selector(playButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
    [self.playButton setTitle:@"暂停" forState:UIControlStateSelected];
    [self.view addSubview:self.playButton];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(200);
    }];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottomMargin).offset(-100);
        make.width.height.mas_equalTo(50);
    }];
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
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0f)
                                          queue:dispatch_get_main_queue()
                                     usingBlock:^(CMTime time) {
            
    }];
    return _player;
}

- (NSArray<YXCAudioModel *> *)musics {
    if (_musics) {
        return _musics;
    }
    _musics = [YXCAudioModel musics];
    return _musics;
}

@end
