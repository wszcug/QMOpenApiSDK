//
//  PlayerViewController.h
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/14.
//

#import <UIKit/UIKit.h>
#import <QMOpenApiSDK/QPSongInfo.h>
NS_ASSUME_NONNULL_BEGIN

@interface PlayerViewController : UIViewController
- (instancetype)initWithSongList:(NSArray<QPSongInfo *> *)songList index:(NSInteger)index autoPlay:(BOOL)autoPlay;
- (void)reloadWithData:(NSArray<QPSongInfo *> *) songList index:(NSInteger)index autoPlay:(BOOL)autoPlay;

@end

NS_ASSUME_NONNULL_END
