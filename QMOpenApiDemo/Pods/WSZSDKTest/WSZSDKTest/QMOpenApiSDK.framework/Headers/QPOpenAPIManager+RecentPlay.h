//
//  QPlayerManager+RecentPlay.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/23.
//

#import <QMOpenApiSDK/QMOpenApiSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPOpenAPIManager (RecentPlay)

/// 拉取用户最近播放歌曲列表
/// @param updateTime 最近更新时间，由接口下发（见返回数据），客户端传入以减少返回数据量，初始可传0
- (void)fetchRecentPlaySongWithUpdateTime:(NSTimeInterval)updateTime completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs,NSTimeInterval updateTime, NSError * _Nullable error))completion;

/// 拉取用户最近播放专辑列表
/// @param updateTime 最近更新时间，由接口下发（见返回数据），客户端传入以减少返回数据量，初始可传0
- (void)fetchRecentPlayAlbumWithUpdateTime:(NSTimeInterval)updateTime completion:(void (^)(NSArray<QPAlbum *> *_Nullable albums,NSTimeInterval updateTime, NSError * _Nullable error))completion;

/// 拉取用户最近播放歌单列表
/// @param updateTime 最近更新时间，由接口下发（见返回数据），客户端传入以减少返回数据量，初始可传0
- (void)fetchRecentPlayFolderWithUpdateTime:(NSTimeInterval)updateTime completion:(void (^)(NSArray<QPFolder *> *_Nullable folders,NSTimeInterval updateTime, NSError * _Nullable error))completion;


@end

NS_ASSUME_NONNULL_END
