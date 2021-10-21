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
@property (nonatomic, strong) UILabel *musicNameLabel; /**< 音乐名称 */
@property (nonatomic, strong) UIButton *lastMusicButton; /**< 上一曲按钮 */
@property (nonatomic, strong) UIButton *nextMusicButton; /**< 下一曲按钮 */
@property (nonatomic, strong) UIProgressView *progressView; /**< 进度条 */
@property (nonatomic, strong) UILabel *currentTimeLabel; /**< 当前播放时间 */
@property (nonatomic, strong) UILabel *durationLabel; /**< 音乐播放时长 */
@property (nonatomic, strong) AVPlayer *player; /**< 播放器 */
@property (nonatomic, strong) AVPlayerItem *playerItem; /**< 播放节目 */
@property (nonatomic, assign) NSInteger index; /**< 下标 */

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
    self.index = 0;
    
    [self setupUI];
    [self setupConstraints];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidFinish) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    __weak typeof(self) wkSelf = self;
    [commandCenter.pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        // 暂停
        [wkSelf pause];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [commandCenter.playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        // 播放
        [wkSelf resumePlay];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [commandCenter.previousTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        // 上一曲
        [wkSelf playLastAudio];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [commandCenter.nextTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
       // 下一曲
        [wkSelf playNextAudio];
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
        // 播放
        [self resumePlay];
    } else {
        // 暂停播放
        [self.player pause];
    }
}


#pragma mark - Public


#pragma mark - Private

/// 播放下一曲
- (void)playNextAudio {
    if (self.index >= self.musics.count - 1) {
        self.index = -1;
    }
    self.index++;
    [self p_changePlay];
}

/// 播放上一曲
- (void)playLastAudio {
    if (self.index <= 0) {
        self.index = self.musics.count;
    }
    self.index--;
    [self p_changePlay];
}

- (void)play {
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

- (void)playDidFinish {
    [self playNextAudio];
}

- (void)resumePlay {
    if (self.playerItem == nil) {
        self.index = 0;
        [self p_changePlay];
    }
    __weak typeof(self) wkSelf = self;
    [self.playerItem seekToTime:self.playerItem.currentTime completionHandler:^(BOOL finished) {
        [wkSelf.player play];
    }];
}

- (AVPlayerItem *)p_getPlayerItem {
    YXCAudioModel *model = self.musics[self.index];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:model.musicUrl];
    [self.imageView sd_setImageWithURL:model.musicImage];
    self.musicNameLabel.text = model.musicName;
    return item;
}

/// 播放信息发生改变
- (void)p_changePlay {
    self.playerItem = [self p_getPlayerItem];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    [self play];
    __weak typeof(self) wkSelf = self;
    [self.playerItem yxc_addOberser:self
                         forKeyPath:@"status"
                            options:NSKeyValueObservingOptionNew
                             change:^(NSObject * _Nullable object, NSDictionary<NSKeyValueChangeKey,id> * _Nullable change) {
        NSLog(@"%lf", CMTimeGetSeconds(wkSelf.playerItem.duration));
    }];
}

/// 将秒数进行转换
/// @param time 秒
- (NSString *)convertStringWithTime:(NSInteger)time {
    if (isnan(time)) time = 0;
    NSInteger min = time / 60;
    NSInteger sec = time - min * 60;
    NSString * minStr = min > 9 ? [NSString stringWithFormat:@"%ld",min] : [NSString stringWithFormat:@"0%ld",min];
    NSString * secStr = sec > 9 ? [NSString stringWithFormat:@"%ld",sec] : [NSString stringWithFormat:@"0%ld",sec];
    NSString * timeStr = [NSString stringWithFormat:@"%@:%@",minStr, secStr];
    return timeStr;
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    self.imageView = [UIImageView new];
    self.imageView.backgroundColor = UIColor.orangeColor;
    self.imageView.layer.cornerRadius = 100;
    self.imageView.layer.masksToBounds = YES;
    [self.view addSubview:self.imageView];
    
    self.musicNameLabel = [UILabel new];
    self.musicNameLabel.textColor = UIColor.blackColor;
    self.musicNameLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:self.musicNameLabel];
    
    self.playButton = [UIButton new];
    self.playButton.backgroundColor = UIColor.orangeColor;
    self.playButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.playButton addTarget:self action:@selector(playButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
    [self.playButton setTitle:@"暂停" forState:UIControlStateSelected];
    [self.view addSubview:self.playButton];
    
    self.lastMusicButton = [UIButton new];
    self.lastMusicButton.backgroundColor = UIColor.orangeColor;
    self.lastMusicButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.lastMusicButton addTarget:self action:@selector(playLastAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.lastMusicButton setTitle:@"上一曲" forState:UIControlStateNormal];
    [self.view addSubview:self.lastMusicButton];
    
    self.nextMusicButton = [UIButton new];
    self.nextMusicButton.backgroundColor = UIColor.orangeColor;
    self.nextMusicButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.nextMusicButton addTarget:self action:@selector(playNextAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.nextMusicButton setTitle:@"下一曲" forState:UIControlStateNormal];
    [self.view addSubview:self.nextMusicButton];
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    self.progressView.progressTintColor = UIColor.orangeColor;
    self.progressView.trackTintColor = UIColor.whiteColor;
    self.progressView.layer.cornerRadius = 2;
    self.progressView.layer.masksToBounds = YES;
    [self.view addSubview:self.progressView];
    
    self.currentTimeLabel = [UILabel new];
    self.currentTimeLabel.text = @"00:00";
    self.currentTimeLabel.textColor = UIColor.blackColor;
    self.currentTimeLabel.font = [UIFont systemFontOfSize:10.0f];
    self.currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.currentTimeLabel];
    
    self.durationLabel = [UILabel new];
    self.durationLabel.text = @"00:00";
    self.durationLabel.textColor = UIColor.blackColor;
    self.durationLabel.font = [UIFont systemFontOfSize:10.0f];
    self.durationLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.durationLabel];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-100);
        make.width.height.mas_equalTo(200);
    }];
    
    [self.musicNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.imageView.mas_top).offset(-50);
    }];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottomMargin).offset(-100);
        make.width.height.mas_equalTo(70);
    }];
    
    [self.lastMusicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.equalTo(self.playButton);
        make.centerX.equalTo(self.view).multipliedBy(0.5);
    }];
    
    [self.nextMusicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.equalTo(self.playButton);
        make.centerX.equalTo(self.view).multipliedBy(1.5);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.centerY.equalTo(self.imageView.mas_bottom).offset(50);
    }];
    
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.progressView).offset(1);
        make.right.equalTo(self.progressView.mas_left).offset(-5);
        make.width.mas_equalTo(40);
    }];
    
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.currentTimeLabel);
        make.left.equalTo(self.progressView.mas_right).offset(5);
        make.width.mas_equalTo(self.currentTimeLabel);
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
    __weak typeof(self) wkSelf = self;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0f)
                                          queue:dispatch_get_main_queue()
                                     usingBlock:^(CMTime time) {
        NSInteger second = (NSInteger)CMTimeGetSeconds(wkSelf.playerItem.currentTime);
        NSInteger duration = (NSInteger)CMTimeGetSeconds(wkSelf.playerItem.duration);
        wkSelf.progressView.progress = (CGFloat)second / (CGFloat)duration;
        wkSelf.currentTimeLabel.text = [wkSelf convertStringWithTime:second];
        wkSelf.durationLabel.text = [wkSelf convertStringWithTime:duration];
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
