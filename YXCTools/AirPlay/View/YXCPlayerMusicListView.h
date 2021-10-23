//
//  YXCPlayerMusicListView.h
//  YXCTools
//
//  Created by lbkj on 2021/10/23.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXCPlayerMusicListView;

NS_ASSUME_NONNULL_BEGIN

@protocol YXCPlayerMusicListViewDelegate <NSObject>

@optional

- (void)listView:(YXCPlayerMusicListView *)listView didSelectedAtIndex:(NSInteger)index;

- (NSInteger)currentPlayAtIndex:(YXCPlayerMusicListView *)list;

@end

@interface YXCPlayerMusicListView : UIView

#pragma mark - Property

@property (nonatomic, weak) id <YXCPlayerMusicListViewDelegate> delegate;


#pragma mark - Method

- (void)show;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
