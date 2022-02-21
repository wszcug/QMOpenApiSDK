//
//  PlayerViewManager.h
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/14.
//

#import <Foundation/Foundation.h>
#import <QMOpenApiSDK/QPSongInfo.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerViewManager : NSObject
+ (instancetype)sharedInstance;
- (void)showWithSongList:(NSArray<QPSongInfo *> *)songList index:(NSInteger)index autoPlay:(BOOL)autoPlay;
@end

NS_ASSUME_NONNULL_END
