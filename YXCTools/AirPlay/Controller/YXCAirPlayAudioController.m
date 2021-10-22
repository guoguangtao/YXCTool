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
#import "YXCSlider.h"
#import "UIImageView+WebCache.h"

@interface YXCAirPlayAudioController ()

@property (nonatomic, strong) NSArray<YXCAudioModel *> *musics; /**< 音乐资源数组 */
@property (nonatomic, strong) NSArray<NSString *> *words; /**< 音乐歌词 */
@property (nonatomic, strong) UIImageView *imageView; /**< 音乐专辑图片 */
@property (nonatomic, strong) UIButton *playButton; /**< 播放按钮 */
@property (nonatomic, strong) UILabel *musicNameLabel; /**< 音乐名称 */
@property (nonatomic, strong) UIButton *lastMusicButton; /**< 上一曲按钮 */
@property (nonatomic, strong) UIButton *nextMusicButton; /**< 下一曲按钮 */
@property (nonatomic, strong) YXCSlider *progressSlider; /**< 进度条 */
@property (nonatomic, strong) UILabel *currentTimeLabel; /**< 当前播放时间 */
@property (nonatomic, strong) UILabel *durationLabel; /**< 音乐播放时长 */
@property (nonatomic, strong) AVPlayer *player; /**< 播放器 */
@property (nonatomic, strong) AVPlayerItem *playerItem; /**< 播放节目 */
@property (nonatomic, assign) NSInteger index; /**< 下标 */
@property (nonatomic, assign) BOOL sliderValueChange; /**< 进度条被拖拽 */

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
    [self addNotification];
    [self setupMPRemoteCommandCenter];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)playButtonClicked:(UIButton *)button {
    if (button.isSelected) {
        // 暂停播放
        [self.player pause];
    } else {
        // 播放
        [self resumePlay];
    }
}


#pragma mark - Public


#pragma mark - Private

- (void)addNotification {
    // 播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidFinish) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

/// 相关远程控制中心
- (void)setupMPRemoteCommandCenter {
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
    [commandCenter.changePlaybackPositionCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        // 进度条发生改变
        CGFloat position = ((MPChangePlaybackPositionCommandEvent *)event).positionTime;
        // 设置进度
        [wkSelf.playerItem seekToTime:CMTimeMakeWithSeconds(position, 1.0) completionHandler:^(BOOL finished) {
            [wkSelf.player play];
        }];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
}

- (void)configNowPlayingCenter {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    YXCAudioModel *model = self.musics[self.index];
    // 当前播放时间
    dictionary[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(CMTimeGetSeconds(self.playerItem.currentTime));
    // 播放速度
    dictionary[MPNowPlayingInfoPropertyPlaybackRate] = @(1.0);
    // 歌曲名称
    dictionary[MPMediaItemPropertyTitle] = model.musicName;
    
    dictionary[MPMediaItemPropertyAlbumTitle] = @"日月何寿 江海滴更漏爱向人间借朝暮 悲喜为酬种柳春莺 知它风尘不可求绵绵更在三生后 谁隔世读关鸠诗说红豆 遍南国未见人长久 见多少来时芳华 去时白头";
    UIImage *image = self.imageView.image;
    MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithBoundsSize:CGSizeMake(100, 100)
                                                                  requestHandler:^UIImage * _Nonnull(CGSize size) {
        return image;
    }];
    dictionary[MPMediaItemPropertyArtwork] = artwork;
    
    dictionary[MPMediaItemPropertyPlaybackDuration] = @(CMTimeGetSeconds(self.playerItem.duration));
    
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = dictionary;
}


- (void)progressValueDidChange {
    self.sliderValueChange = YES;
    NSInteger second = self.progressSlider.value * CMTimeGetSeconds(self.playerItem.duration);
    self.currentTimeLabel.text = [self convertStringWithTime:second];
}

- (void)progressSeek {
    NSInteger second = self.progressSlider.value * CMTimeGetSeconds(self.playerItem.duration);
    __weak typeof(self) wkSelf = self;
    [self.playerItem seekToTime:CMTimeMake(second, 1.0f) completionHandler:^(BOOL finished) {
        [wkSelf.player play];
        wkSelf.sliderValueChange = NO;
    }];
}

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
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        if (status == AVPlayerItemStatusReadyToPlay) {
            [wkSelf configNowPlayingCenter];
        }
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
    
    self.progressSlider = [YXCSlider new];
    self.progressSlider.minimumValue = 0.0f;
    self.progressSlider.maximumValue = 1.0f;
    self.progressSlider.minimumTrackTintColor = UIColor.whiteColor;
    self.progressSlider.maximumTrackTintColor = kColorFromHexCode(0xE6E6E6);
    UIImage *thumbImage = [UIImage imageNamed:@"player_slider"];
    [self.progressSlider setThumbImage:thumbImage forState:UIControlStateNormal];
    [self.progressSlider addTarget:self action:@selector(progressValueDidChange) forControlEvents:UIControlEventValueChanged];
    [self.progressSlider addTarget:self action:@selector(progressSeek) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchUpInside];
    [self.view addSubview:self.progressSlider];
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
    
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.progressSlider).offset(-1.5);
        make.right.equalTo(self.progressSlider.mas_left).offset(-5);
        make.width.mas_equalTo(40);
    }];
    
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.currentTimeLabel);
        make.left.equalTo(self.progressSlider.mas_right).offset(5);
        make.width.mas_equalTo(self.currentTimeLabel);
    }];
    
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.centerY.equalTo(self.imageView.mas_bottom).offset(50);
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
        if (wkSelf.sliderValueChange) {
            return;
        }
        NSInteger second = (NSInteger)CMTimeGetSeconds(wkSelf.playerItem.currentTime);
        NSInteger duration = (NSInteger)CMTimeGetSeconds(wkSelf.playerItem.duration);
        if (duration == 0) {
            duration = 1;
        }
        [wkSelf.progressSlider setValue:(CGFloat)second / (CGFloat)duration animated:YES];
        wkSelf.currentTimeLabel.text = [wkSelf convertStringWithTime:second];
        wkSelf.durationLabel.text = [wkSelf convertStringWithTime:duration];
    }];
    [_player yxc_addOberser:self forKeyPath:@"timeControlStatus" options:NSKeyValueObservingOptionNew change:^(NSObject * _Nullable object, NSDictionary<NSKeyValueChangeKey,id> * _Nullable change) {
        AVPlayerTimeControlStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        switch (status) {
            case AVPlayerTimeControlStatusPaused:
                wkSelf.playButton.selected = NO;
                break;
            case AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate:
                
                break;
            case AVPlayerTimeControlStatusPlaying:
                wkSelf.playButton.selected = YES;
                break;
        }
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

- (NSArray<NSString *> *)words {
    if (_words) {
        return _words;
    }
    _words = @[
        @"盼你渡口 待你桥头",
        @"松香接地走",
        @"挥癯龙绣虎出怀袖",
        @"起微石落海连波动",
        @"描数曲箜篌线同轴",
        @"勒笔烟直大漠 沧浪盘虬",
        @"一纸淋漓漫点方圆透",
        @"记我 长风万里绕指未相勾",
        @"形生意成 此意 逍遥不游",
        @"日月何寿 江海滴更漏",
        @"爱向人间借朝暮 悲喜为酬",
        @"种柳春莺 知它风尘不可求",
        @"绵绵更在三生后 谁隔世读关鸠",
        @"诗说红豆 遍南国未见人长久 见多少",
        @"来时芳华 去时白头"
    ];
    return _words;
}

@end
